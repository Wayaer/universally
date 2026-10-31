#!/usr/bin/env python3
"""Flutter HarmonyOS 打包脚本。"""
import datetime
import getopt
import glob
import os
import re
import shutil
import subprocess
import sys

RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'

OUTPUT_TYPES = ('app', 'hap', 'har', 'hsp')
BUILD_TYPES = ('release', 'debug')
TARGET_PLATFORMS = {
    0: 'ohos-arm64',
    1: 'ohos-arm',
    2: 'ohos-x64',
    3: 'ohos-arm,ohos-arm64,ohos-x64',
}


def show_help() -> None:
    """显示帮助信息"""
    print(f'{GREEN}用法: {sys.argv[0]} [选项]')
    print(f'{GREEN}Flutter HarmonyOS打包脚本')
    print()
    print(f'{GREEN}选项:')
    print(f'{GREEN}  -n app_name         应用名称 {NC}(默认: 空)')
    print(f'{GREEN}  -c channel          渠道名 {NC}(默认: ohos)')
    print(f'{GREEN}  -o output_type      输出类型 {NC}[app(default), hap, har, hsp]')
    print(f'{GREEN}  -t target_platform  目标平台 {NC}[0:ohos-arm64, 1:ohos-arm, 2:ohos-x64, 3:ohos-arm+arm64+x64]')
    print(f'{GREEN}  -b build_type       构建类型 {NC}[release(default), debug]')
    print(f'{GREEN}  -p main_path        入口文件路径 {NC}(默认: lib/main.dart)')
    print(f'{GREEN}  -h                  显示帮助信息')
    print()


def validate_parameters(output_type: str, target_platform: int, build_type: str, main_path: str) -> None:
    """验证输入参数"""
    if output_type not in OUTPUT_TYPES:
        print(f'{RED}错误: 输出类型必须是 app, hap, har 或 hsp{NC}', file=sys.stderr)
        sys.exit(1)

    if target_platform not in TARGET_PLATFORMS:
        print(f'{RED}错误: 目标平台必须是 0-3 之间的数字{NC}', file=sys.stderr)
        sys.exit(1)

    if build_type not in BUILD_TYPES:
        print(f'{RED}错误: 构建类型必须是 release 或 debug{NC}', file=sys.stderr)
        sys.exit(1)

    if not os.path.isfile(main_path):
        print(f'{RED}错误: 入口文件 {main_path} 不存在{NC}', file=sys.stderr)
        sys.exit(1)

    if not os.path.isdir('ohos'):
        print(f'{RED}错误: ohos目录不存在，请确认在Flutter项目根目录执行此脚本{NC}', file=sys.stderr)
        sys.exit(1)


def extract_version() -> str:
    """从 pubspec.yaml 提取版本号"""
    try:
        with open('pubspec.yaml', encoding='utf-8') as file:
            for line in file:
                match = re.match(r'^version: (.*)$', line.strip())
                if match:
                    return match.group(1).strip()
    except FileNotFoundError:
        print(f'{RED}错误: pubspec.yaml 文件不存在{NC}', file=sys.stderr)
        sys.exit(1)

    print(f'{RED}错误: 无法从 pubspec.yaml 提取版本号{NC}', file=sys.stderr)
    sys.exit(1)


def get_target_platform_args(platform: int) -> str:
    """获取目标平台参数"""
    return TARGET_PLATFORMS.get(platform, 'ohos-arm64')


def move_output_file(src_pattern: str, base_dest: str, ext: str) -> None:
    """移动输出文件并保留 unsigned 标识"""
    files = [path for path in glob.glob(src_pattern) if os.path.isfile(path)]
    if not files:
        print(f'{YELLOW}警告: 未找到匹配 {src_pattern} 的文件{NC}')
        return

    src = sorted(files)[0]
    unsigned_suffix = '-unsigned' if 'unsigned' in os.path.basename(src) else ''
    dest = f'{base_dest}{unsigned_suffix}.{ext}'

    shutil.move(src, dest)
    print(f'已移动: {src} -> {dest}')


def main() -> None:
    print(f'{BLUE}========== 💪 开始打包HarmonyOS 💪 =========={NC}')

    app_name = ''
    channel = 'ohos'
    output_type = 'app'
    target_platform = 0
    build_type = 'release'
    main_path = 'lib/main.dart'
    current_date = datetime.datetime.now().strftime('%Y%m%d%H%M')

    show_help()

    try:
        opts, _args = getopt.getopt(sys.argv[1:], 'n:c:o:t:b:p:h')
    except getopt.GetoptError as error:
        print(f'{RED}错误: 未知选项 {error.opt}{NC}', file=sys.stderr)
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

    validate_parameters(output_type, target_platform, build_type, main_path)
    version = extract_version()
    target_platform_str = get_target_platform_args(target_platform)

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

    build_command = ['flutter', 'build', output_type, f'--{build_type}']
    if channel:
        build_command += ['--dart-define', f'channel={channel}']
    build_command += ['--target-platform', target_platform_str, '-t', main_path]

    print(f'{BLUE}执行命令:{NC} {" ".join(build_command)}')
    try:
        subprocess.run(build_command, check=True)
    except subprocess.CalledProcessError:
        print(f'{RED}错误: 打包命令执行失败{NC}', file=sys.stderr)
        sys.exit(1)

    output_dir = f'app/ohos/{build_type}/'
    os.makedirs(output_dir, exist_ok=True)
    print(f'{BLUE}输出目录: {output_dir}{NC}')

    src_pattern = f'build/ohos/{output_type}/*.{output_type}'
    base_dest = os.path.join(output_dir, f'{app_name}-{channel}-v{version}-{current_date}')
    move_output_file(src_pattern, base_dest, output_type)

    print(f'{GREEN}========== ✅ 打包完成 ✅ =========={NC}')
    print(f'{GREEN}输出目录: {output_dir}{NC}')


if __name__ == '__main__':
    main()
