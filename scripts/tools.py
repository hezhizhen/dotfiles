import argparse
import csv
import filecmp
import os
import re
import shlex
import shutil
import stat
import subprocess
import tempfile
import unicodedata
from pathlib import Path


FIELDS = ("name", "cli", "status", "config", "website", "github", "version_command", "version")
VERSION_PATTERN = re.compile(r"^[^0-9]*([0-9]+(?:\.[0-9]+)+[A-Za-z0-9.+-]*)")


def read_tools(path):
    with path.open(encoding="utf-8", newline="") as source:
        reader = csv.DictReader(source, strict=True)
        fields = reader.fieldnames
        if not fields or not set(FIELDS).issubset(fields) or len(fields) != len(set(fields)):
            raise ValueError(f"{path}: 缺少必要字段或存在重复字段，必需字段：{', '.join(FIELDS)}")
        rows = []
        names = {"all"}
        for row in reader:
            if None in row or None in row.values():
                raise ValueError(f"{path}:{reader.line_num}: 字段数量与表头不一致")
            selectors = {value.casefold() for value in (row["name"], row["cli"]) if value}
            if not row["name"].strip() or names & selectors:
                raise ValueError(f"{path}:{reader.line_num}: 工具名为空或名称/CLI 名称重复（all 为保留字）")
            if row["status"] not in ("active", "inactive"):
                raise ValueError(f"{path}:{reader.line_num}: status 必须为 active 或 inactive")
            if row["config"]:
                config = Path(row["config"])
                if not config.parts or config.is_absolute() or ".." in config.parts:
                    raise ValueError(f"{path}:{reader.line_num}: config 必须为仓库内文件或子目录的相对路径")
            names.update(selectors)
            rows.append(row)
    return fields, rows


def config_files(path, follow_symlinks=True):
    mode = path.lstat().st_mode
    # 仅跟随配置入口的符号链接，避免递归进入目录外的内容。
    if follow_symlinks and stat.S_ISLNK(mode):
        try:
            mode = path.stat().st_mode
        except FileNotFoundError:
            return []
    if stat.S_ISREG(mode):
        return [path]
    files = []
    if stat.S_ISDIR(mode):
        for child in path.iterdir():
            files.extend(config_files(child, follow_symlinks=False))
    return files


def count_config_tree_entries(path):
    count = 0
    pending = [path]
    try:
        while pending:
            with os.scandir(pending.pop()) as entries:
                for entry in entries:
                    count += 1
                    if entry.is_dir(follow_symlinks=False):
                        pending.append(entry.path)
    except OSError:
        return None
    return count


def config_tree_rows(repo_path, local_path, depth=0):
    paths = (repo_path, local_path)
    modes = []
    markers = ["", ""]
    names = set()
    for side, path in enumerate(paths):
        mode = 0
        try:
            mode = path.lstat().st_mode
        except (FileNotFoundError, NotADirectoryError):
            pass
        except OSError:
            markers[side] = "无法读取"
        if depth == 0 and stat.S_ISLNK(mode):
            try:
                mode = path.stat().st_mode
            except OSError:
                markers[side] = "链接目标不可用"
        modes.append(stat.S_IFMT(mode))
    if not any(modes) and not any(markers):
        return
    if not any(markers) and not all(modes):
        side = 0 if modes[0] else 1
        markers[side] = "仅仓库" if side == 0 else "仅本机"
        if stat.S_ISDIR(modes[side]):
            count = count_config_tree_entries(paths[side])
            markers[side] += "，无法统计" if count is None else f"，{count} 项"
    elif not any(markers) and modes[0] != modes[1]:
        types = {stat.S_IFREG: "文件", stat.S_IFDIR: "目录", stat.S_IFLNK: "链接"}
        markers = [f"类型不同：{types.get(mode, '其他')}" for mode in modes]
    else:
        for side, path in enumerate(paths):
            if stat.S_ISDIR(modes[side]):
                try:
                    names.update(child.name for child in path.iterdir())
                except OSError:
                    markers[side] = "无法读取"
    cells = []
    for path, mode, marker in zip(paths, modes, markers):
        suffix = "/" if stat.S_ISDIR(mode) else "@" if stat.S_ISLNK(mode) else ""
        cells.append("  " * depth + path.name + suffix + (f" [{marker}]" if marker else "") if mode or marker else "")
    yield tuple(cells)
    for name in sorted(names, key=os.fsencode):
        yield from config_tree_rows(repo_path / name, local_path / name, depth + 1)


def print_config_tree(repo_path, local_path):
    def display_width(value):
        return sum(0 if unicodedata.combining(char) else 2 if unicodedata.east_asian_width(char) in "WF" else 1 for char in value)

    rows = list(config_tree_rows(repo_path, local_path))
    width = max((display_width(left) for left, _ in rows), default=0)
    for left, right in rows:
        print(f"{left}{' ' * (width - display_width(left))} │ {right}".rstrip())


def compare_tools(rows, root, tool=None):
    if tool:
        row = next((row for row in rows if tool.casefold() in (row["name"].casefold(), row["cli"].casefold())), None)
        if row is None:
            raise ValueError(f"未知工具：{tool}，请运行 task compare 查看可选工具")
        if row["status"] != "active":
            raise ValueError(f"{tool}: 工具已停用")
        if not row["config"]:
            raise ValueError(f"{tool}: 未设置配置路径")
        rows = [row]
    rows = [row for row in rows if row["status"] == "active" and row["config"]]
    for row in rows:
        try:
            (root / row["config"]).lstat()
        except (FileNotFoundError, NotADirectoryError):
            raise ValueError(f"{row['name']}: 仓库中不存在 {row['config']!r}") from None

    if rows:
        print("目录树左侧仓库、右侧本机，空白表示缺失；仅表示结构：仅仓库／仅本机、类型不同、链接目标不可用、无法读取／无法统计；/ 为目录，@ 为符号链接。内容相同则跳过，本机链接（文件或目录）按目标内容比较。")
    for row in rows:
        config = Path(row["config"])
        repo_path = root / config
        local_path = Path.home() / config
        print(f"\n{row['name']}\n仓库：{repo_path}\n本机：{local_path}")
        print_config_tree(repo_path, local_path)
    if rows:
        print(flush=True)

    for row in rows:
        config = Path(row["config"])
        repo_path = root / config
        local_path = Path.home() / config
        for repo_file in sorted(config_files(repo_path), key=os.fsencode):
            local_file = local_path / repo_file.relative_to(repo_path)
            if local_file.is_file():
                try:
                    if filecmp.cmp(repo_file, local_file, shallow=False):
                        continue
                except OSError:
                    # 预检查失败时仍交给 VS Code 展示文件错误。
                    pass
                command = ["code", "--diff", str(repo_file), str(local_file)]
            else:
                if local_file.is_dir():
                    print(f"! 本地路径是目录：{local_file}", flush=True)
                else:
                    print(f"∅ 本地无可比较文件：{local_file}", flush=True)
                command = ["code", str(repo_file)]
            subprocess.run(command, stdin=subprocess.DEVNULL, check=True)


def read_version(command):
    if not command:
        return ""
    result = subprocess.run(["bash", "-c", command], stdin=subprocess.DEVNULL, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, encoding="utf-8", errors="replace")
    match = VERSION_PATTERN.match(result.stdout.partition("\n")[0])
    return match.group(1) if result.returncode == 0 and match else ""


def update_versions(path, fields, rows):
    for row in rows:
        if row["status"] == "active":
            row["version"] = read_version(row["version_command"])

    snapshot = None
    try:
        with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8", newline="", dir=path.parent, prefix=f".{path.name}.", delete=False) as output:
            snapshot = Path(output.name)
            writer = csv.DictWriter(output, fieldnames=fields, lineterminator="\n")
            writer.writeheader()
            writer.writerows(rows)
        snapshot.chmod(0o644)
        snapshot.replace(path)
    finally:
        if snapshot is not None:
            snapshot.unlink(missing_ok=True)
    print(f"已更新 {path}")


def print_compare_help(rows):
    usage = (
        ("task compare", "显示帮助和可选工具"),
        ("task compare -- nvim", "比较 Neovim 配置"),
        ("task compare -- all", "比较所有工具配置"),
        ('task compare -- "Visual Studio Code"', "比较指定工具配置"),
    )
    width = max(len(command) for command, _ in usage)
    print("用法：")
    for command, description in usage:
        print(f"  {command:<{width}}  {description}")
    choices = [("CLI", "完整名称")]
    for row in rows:
        if row["status"] == "active" and row["config"]:
            choices.append((shlex.quote(row["cli"] or "-"), shlex.quote(row["name"])))
    width = max(len(cli) for cli, _ in choices)
    print("\n可选工具（完整名称或 CLI 名称，不区分大小写，带空格需加引号）：")
    for cli, name in choices:
        print(f"  {cli:<{width}}  {name}")


def main():
    parser = argparse.ArgumentParser(description="读取工具清单，对比配置或更新本机版本。")
    parser.add_argument("command", choices=("compare", "versions"))
    parser.add_argument("csv", type=Path, nargs="?", default=Path("tools.csv"))
    parser.add_argument("tool", nargs="?", help="仅 compare：完整名称、CLI 名称或 all；留空显示帮助和可选工具")
    args = parser.parse_args()
    if args.tool is not None and args.command != "compare":
        parser.error("工具参数仅适用于 compare")
    try:
        fields, rows = read_tools(args.csv)
        if args.command == "compare":
            if not args.tool:
                print_compare_help(rows)
            else:
                if shutil.which("code") is None:
                    raise ValueError("请将 VS Code 的 code 命令加入 PATH。")
                compare_tools(rows, args.csv.resolve().parent, None if args.tool.casefold() == "all" else args.tool)
        else:
            update_versions(args.csv, fields, rows)
    except (csv.Error, OSError, ValueError) as error:
        parser.exit(1, f"{error}\n")
    except subprocess.CalledProcessError as error:
        parser.exit(error.returncode)


if __name__ == "__main__":
    main()
