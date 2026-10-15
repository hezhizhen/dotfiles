import argparse
import csv
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


def compare_tools(rows, root):
    rows = [row for row in rows if row["status"] == "active" and row["config"]]
    for row in rows:
        try:
            (root / row["config"]).lstat()
        except (FileNotFoundError, NotADirectoryError):
            raise ValueError(f"{row['name']}: 仓库中不存在 {row['config']!r}") from None

    for row in rows:
        config = Path(row["config"])
        repo_path = root / config
        local_path = Path.home() / config
        for repo_file in sorted(config_files(repo_path), key=os.fsencode):
            local_file = local_path / repo_file.relative_to(repo_path)
            if local_file.is_file():
                command = ["code", "--diff", str(repo_file), str(local_file)]
            else:
                if local_file.is_dir():
                    print(f"! 本地路径是目录：{local_file}", flush=True)
                else:
                    print(f"∅ 本地不存在：{local_file}", flush=True)
                command = ["code", str(repo_file)]
            subprocess.run(command, stdin=subprocess.DEVNULL, check=True)


def read_version(command):
    if not command:
        return "∅"
    result = subprocess.run(["bash", "-c", command], stdin=subprocess.DEVNULL, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, encoding="utf-8", errors="replace")
    match = VERSION_PATTERN.match(result.stdout.partition("\n")[0])
    return match.group(1) if result.returncode == 0 and match else "∅"


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
    args = parser.parse_args()
    try:
        fields, rows = read_tools(args.csv)
        if args.command == "compare":
            compare_tools(rows, args.csv.resolve().parent)
        else:
            update_versions(args.csv, fields, rows)
    except (csv.Error, OSError, ValueError) as error:
        parser.exit(1, f"{error}\n")
    except subprocess.CalledProcessError as error:
        parser.exit(error.returncode)


if __name__ == "__main__":
    main()
