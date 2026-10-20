import argparse
import csv
import filecmp
import os
import re
import stat
import subprocess
import tempfile
from pathlib import Path


FIELDS = ("name", "status", "config", "website", "github", "version_command", "version")
VERSION_PATTERN = re.compile(r"^[^0-9]*([0-9]+(?:\.[0-9]+)+[A-Za-z0-9.+-]*)")


def read_tools(path):
    with path.open(encoding="utf-8", newline="") as source:
        reader = csv.DictReader(source, strict=True)
        fields = reader.fieldnames
        if not fields or not set(FIELDS).issubset(fields) or len(fields) != len(set(fields)):
            raise ValueError(f"{path}: 缺少必要字段或存在重复字段，必需字段：{', '.join(FIELDS)}")
        rows = []
        names = set()
        for row in reader:
            if None in row or None in row.values():
                raise ValueError(f"{path}:{reader.line_num}: 字段数量与表头不一致")
            if not row["name"].strip() or row["name"] in names:
                raise ValueError(f"{path}:{reader.line_num}: 工具名为空或重复")
            if row["status"] not in ("active", "inactive"):
                raise ValueError(f"{path}:{reader.line_num}: status 必须为 active 或 inactive")
            if row["config"]:
                config = Path(row["config"])
                if not config.parts or config.is_absolute() or ".." in config.parts:
                    raise ValueError(f"{path}:{reader.line_num}: config 必须为仓库内文件或子目录的相对路径")
            names.add(row["name"])
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


def print_config_tree(repo_path, local_path, prefix="", connector=""):
    names = []
    suffix = ""
    failed_side = None
    try:
        modes = []
        for side, path in (("仓库", repo_path), ("本机", local_path)):
            mode = 0
            try:
                mode = path.lstat().st_mode
            except (FileNotFoundError, NotADirectoryError):
                pass
            if not connector and stat.S_ISLNK(mode):
                try:
                    mode = path.stat().st_mode
                except OSError:
                    failed_side = side
                    raise
            modes.append(stat.S_IFMT(mode))
        repo_mode, local_mode = modes
        repo_dir, local_dir = map(stat.S_ISDIR, modes)
        if not repo_mode:
            marker = "仅本机"
        elif not local_mode:
            marker = "仅仓库"
        elif repo_mode != local_mode:
            types = {stat.S_IFREG: "文件", stat.S_IFDIR: "目录", stat.S_IFLNK: "链接"}
            marker = f"类型不同：仓库{types.get(repo_mode, '其他')}／本机{types.get(local_mode, '其他')}"
        else:
            marker = ""
        suffix = "/" if repo_dir or local_dir else "@" if stat.S_ISLNK(repo_mode) or stat.S_ISLNK(local_mode) else ""
        if repo_dir and local_dir:
            names = sorted({child.name for directory in (repo_path, local_path) for child in directory.iterdir()}, key=os.fsencode)
        elif (repo_dir or local_dir) and (not repo_mode or not local_mode):
            count = count_config_tree_entries(repo_path if repo_dir else local_path)
            marker += "，无法统计" if count is None else f"，{count} 项"
    except OSError:
        marker = "无法读取"
        if failed_side is not None:
            marker, suffix = f"{failed_side}链接目标不可用", "@"
    print(f"{prefix}{connector}{repo_path.name}{suffix}" + (f" [{marker}]" if marker else ""))
    child_prefix = prefix + ("    " if connector == "└── " else "│   " if connector else "")
    for index, name in enumerate(names):
        child_connector = "└── " if index == len(names) - 1 else "├── "
        print_config_tree(repo_path / name, local_path / name, child_prefix, child_connector)


def compare_tools(rows, root, tool=None):
    if tool:
        row = next((row for row in rows if row["name"] == tool), None)
        if row is None:
            raise ValueError(f"未知工具：{tool}，请使用 tools.csv 中的 name")
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
        print("目录树只表示结构：仅仓库／仅本机、类型不同、链接目标不可用、无法读取／无法统计；/ 为目录，@ 为符号链接。内容相同则跳过，本机链接（文件或目录）按目标内容比较。")
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


def main():
    parser = argparse.ArgumentParser(description="读取工具清单，对比配置或更新本机版本。")
    parser.add_argument("command", choices=("compare", "versions"))
    parser.add_argument("csv", type=Path, nargs="?", default=Path("tools.csv"))
    parser.add_argument("--tool", help="仅 compare：指定 tools.csv 中的工具名，区分大小写")
    args = parser.parse_args()
    if args.tool is not None and args.command != "compare":
        parser.error("--tool 仅适用于 compare")
    try:
        fields, rows = read_tools(args.csv)
        if args.command == "compare":
            compare_tools(rows, args.csv.resolve().parent, args.tool)
        else:
            update_versions(args.csv, fields, rows)
    except (csv.Error, OSError, ValueError) as error:
        parser.exit(1, f"{error}\n")
    except subprocess.CalledProcessError as error:
        parser.exit(error.returncode)


if __name__ == "__main__":
    main()
