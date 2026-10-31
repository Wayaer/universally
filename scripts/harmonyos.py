#!/usr/bin/env python3
import os
import re
import sys
import getopt
import datetime
import shutil

# 颜色定义
RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'  # 无颜色

# 显示帮助信息
def show_help():
    print(f"{GREEN}用法: {sys.argv[0]} [选项]")
    print(f"{GREEN}Flutter HarmonyOS打包脚本")
    print()
    print(f"{GREEN}选项:")
    print(f"{GREEN}  -n app_name         应用名称 {NC}(默认: 空)")
    print(f"{GREEN}  -c channel          渠道名 {NC}(默认: ohos)")
    print(f"{GREEN}  -o output_type      输出类型 {NC}[app(default), hap, har, hsp]")
    print(f"{GREEN}  -t target_platform  目标平台 {NC}[0:ohos-arm64, 1:ohos-arm, 2:ohos-x64, 3:ohos-arm+arm64+x64]")
    print(f"{GREEN}  -b build_type       构建类型 {NC}[release(default), debug]")
    print(f"{GREEN}  -p main_path        入口文件路径 {NC}(默认: lib/main.dart)")
    print(f"{GREEN}  -h                  显示帮助信息")
    print()

# 参数验证
def validate_parameters(output_type, target_platform, build_type, main_path):
    if not re.match(r'^(app|hap|har|hsp)$', output_type):
        print(f"{RED}错误: 输出类型必须是 app, hap, har 或 hsp{NC}", file=sys.stderr)
        sys.exit(1)

    if not re.match(r'^[0-3]$', str(target_platform)):
        print(f"{RED}错误: 目标平台必须是 0-3 之间的数字{NC}", file=sys.stderr)
        sys.exit(1)

    if not re.match(r'^(release|debug)$', build_type):
        print(f"{RED}错误: 构建类型必须是 release 或 debug{NC}", file=sys.stderr)
        sys.exit(1)

    if not os.path.isfile(main_path):
        print(f"{RED}错误: 入口文件 {main_path} 不存在{NC}", file=sys.stderr)
        sys.exit(1)

    if not os.path.isdir("ohos"):
        print(f"{RED}错误: ohos目录不存在，请确认在Flutter项目根目录执行此脚本{NC}", file=sys.stderr)
        sys.exit(1)

# 提取版本号
def extract_version():
    try:
        with open('pubspec.yaml', 'r') as f:
            for line in f:
                match = re.match(r'^version: (.*)$', line.strip())
                if match:
                    return match.group(1)
        print(f"{RED}错误: 无法从 pubspec.yaml 提取版本号{NC}", file=sys.stderr)
        sys.exit(1)
    except FileNotFoundError:
        print(f"{RED}错误: pubspec.yaml 文件不存在{NC}", file=sys.stderr)
        sys.exit(1)

# 获取目标平台参数转换
def get_target_platform_args(platform):
    platform_map = {
        0: "ohos-arm64",
        1: "ohos-arm",
        2: "ohos-x64",
        3: "ohos-arm,ohos-arm64,ohos-x64"
    }
    return platform_map.get(platform, "ohos-arm64")

# 移动输出文件的辅助函数
def move_output_file(src_pattern, base_dest, ext):
    import glob
    files = glob.glob(src_pattern)
    # 过滤掉目录，只保留文件
    files = [f for f in files if os.path.isfile(f)]

    if not files:
        print(f"{YELLOW}警告: 未找到匹配 {src_pattern} 的文件{NC}")
        return False

    # 获取第一个匹配文件的文件名
    filename = os.path.basename(files[0])

    # 检查文件名是否包含unsigned
    unsigned_suffix = "-unsigned" if "unsigned" in filename else ""

    # 构建最终目标文件名
    dest = f"{base_dest}{unsigned_suffix}.{ext}"

    # 移动文件
    shutil.move(files[0], dest)
    print(f"已移动: {files[0]} -> {dest}")
    return True

# 主执行函数
def main():
    print(f"{BLUE}========== 💪 开始打包HarmonyOS 💪 =========={NC}")

    # 初始化参数
    app_name = ""
    channel = "ohos"
    output_type = "app"
    target_platform = 0
    build_type = "release"
    main_path = "lib/main.dart"
    current_date = datetime.datetime.now().strftime("%Y%m%d%H%M")

    # 显示帮助信息
    show_help()

    # 解析参数
    try:
        opts, args = getopt.getopt(sys.argv[1:], "n:c:o:t:b:p:h")
    except getopt.GetoptError as e:
        print(f"{RED}错误: 未知选项 {e.opt}{NC}", file=sys.stderr)
        sys.exit(1)

    for opt, arg in opts:
        if opt == '-n':
            app_name = arg
        elif opt == '-c':
            channel = arg
        elif opt == '-o':
            output_type = arg
        elif opt == '-t':
            target_platform = int(arg)
        elif opt == '-b':
            build_type = arg
        elif opt == '-p':
            main_path = arg
        elif opt == '-h':
            sys.exit(0)

    # 验证参数
    validate_parameters(output_type, target_platform, build_type, main_path)

    # 提取版本号
    version = extract_version()

    # 获取目标平台字符串
    target_platform_str = get_target_platform_args(target_platform)

    # 构建渠道参数
    channel_arguments = f"--dart-define channel={channel}" if channel else ""

    # 显示打包信息
    print(f"""
 {YELLOW}┌---------------------------------------------------------------{NC}
 {YELLOW}|    版本: {version}
 {YELLOW}|    输出名称: {app_name}
 {YELLOW}|    渠道: {channel}
 {YELLOW}|    类型: {output_type}
 {YELLOW}|    构建类型: {build_type}
 {YELLOW}|    目标平台: {target_platform_str}
 {YELLOW}|    入口: {main_path}
 {YELLOW}└---------------------------------------------------------------{NC}""")

    # 构建并执行打包命令
    target_platform_args = f"--target-platform {target_platform_str}"
    build_command = (f"flutter build {output_type} --{build_type} "
                    f"{channel_arguments} {target_platform_args} -t {main_path}")

    print(f"{BLUE}执行命令:{NC} {build_command}")
    exit_code = os.system(build_command)
    if exit_code != 0:
        print(f"{RED}错误: 打包命令执行失败{NC}", file=sys.stderr)
        sys.exit(1)

    # 准备输出目录
    output_dir = f"app/ohos/{build_type}/"
    os.makedirs(output_dir, exist_ok=True)
    print(f"{BLUE}输出目录: {output_dir}{NC}")

    # 移动输出文件
    src_pattern = f"build/ohos/{output_type}/*.{output_type}"
    base_dest_name = f"{app_name}-{channel}-v{version}-{current_date}"
    full_base_dest = os.path.join(output_dir, base_dest_name)

    move_output_file(src_pattern, full_base_dest, output_type)

    print(f"{GREEN}========== ✅ 打包完成 ✅ =========={NC}")
    print(f"{GREEN}输出目录: {output_dir}{NC}")

if __name__ == "__main__":
    main()