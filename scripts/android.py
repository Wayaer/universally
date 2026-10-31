#!/usr/bin/env python3
"""Flutter Android 打包脚本。"""
import argparse
import os
import re
import subprocess
import sys
from datetime import datetime

RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'

OUTPUT_TYPES = ('apk', 'appbundle', 'aar')
BUILD_TYPES = ('release', 'profile', 'debug')
TARGET_PLATFORMS = {
    0: 'android-arm64',
    1: 'android-arm',
    2: 'android-arm,android-arm64',
    3: 'android-arm,android-arm64,android-x64',
}


def show_help(parser: argparse.ArgumentParser) -> None:
    """显示帮助信息"""
    print(f'{GREEN}用法: {sys.argv[0]} [选项]')
    print(f'{GREEN}Flutter Android打包脚本')
    print()
    print(f'{GREEN}选项:')
    parser.print_help()
    print(NC)


def validate_parameters(args: argparse.Namespace) -> None:
    """验证输入参数"""
    if args.output_type not in OUTPUT_TYPES:
        print(f'{RED}错误: 输出类型必须是 apk, appbundle 或 aar{NC}', file=sys.stderr)
        sys.exit(1)

    if args.target_platform not in TARGET_PLATFORMS:
        print(f'{RED}错误: 目标平台必须是 0-3 之间的数字{NC}', file=sys.stderr)
        sys.exit(1)

    if args.build_type not in BUILD_TYPES:
        print(f'{RED}错误: 构建类型必须是 release, profile 或 debug{NC}', file=sys.stderr)
        sys.exit(1)

    if not os.path.isfile(args.main_path):
        print(f'{RED}错误: 入口文件 {args.main_path} 不存在{NC}', file=sys.stderr)
        sys.exit(1)

    if not os.path.isdir('android'):
        print(f'{RED}错误: android目录不存在，请确认在Flutter项目根目录执行此脚本{NC}', file=sys.stderr)
        sys.exit(1)


def extract_version() -> str:
    """从 pubspec.yaml 提取版本号"""
    try:
        with open('pubspec.yaml', encoding='utf-8') as file:
            content = file.read()
    except FileNotFoundError:
        print(f'{RED}错误: 未找到 pubspec.yaml 文件{NC}', file=sys.stderr)
        sys.exit(1)

    match = re.search(r'^version: (.*)$', content, re.MULTILINE)
    if not match:
        print(f'{RED}错误: 无法从 pubspec.yaml 提取版本号{NC}', file=sys.stderr)
        sys.exit(1)
    return match.group(1).strip()


def get_target_platform_args(platform: int) -> str:
    """获取目标平台参数"""
    return TARGET_PLATFORMS.get(platform, '')


def move_apk_file(
    abi: str,
    suffix: str,
    build_type: str,
    app_name: str,
    channel: str,
    version: str,
    current_date: str,
) -> None:
    """移动 APK 文件"""
    src = f"build/app/outputs/flutter-apk/app{'-' + abi if abi else ''}-{build_type}.apk"
    dest = f"app/android/{build_type}/{app_name}-{channel}-{suffix}{version}-{current_date}.apk"

    if os.path.isfile(src):
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        os.replace(src, dest)
        print(f'已移动: {src} -> {dest}')
    else:
        print(f'{YELLOW}警告: 未找到 {abi} APK 文件 {src}{NC}')


def main() -> None:
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-n', '--app-name', default='', help='应用名称 (默认: 空)')
    parser.add_argument('-c', '--channel', default='android', help='渠道名 (默认: android)')
    parser.add_argument('-o', '--output-type', default='apk', help='输出类型 [apk(default), appbundle, aar]')
    parser.add_argument('-t', '--target-platform', type=int, default=2, help='目标平台 [0:arm64, 1:arm, 2:arm+arm64, 3:arm+arm64+x64]')
    parser.add_argument('-b', '--build-type', default='release', help='构建类型 [release(default), profile, debug]')
    parser.add_argument('-p', '--main-path', default='lib/main.dart', help='入口文件路径 (默认: lib/main.dart)')
    parser.add_argument('-s', '--no-split-abi', action='store_true', help='不拆分ABI (默认: 拆分)')
    parser.add_argument('-h', '--help', action='store_true', help='显示帮助信息')

    args = parser.parse_args()
    show_help(parser)
    if args.help:
        sys.exit(0)

    app_name = args.app_name
    channel = args.channel
    output_type = args.output_type
    build_type = args.build_type
    main_path = args.main_path
    split_abi = not args.no_split_abi
    current_date = datetime.now().strftime('%Y%m%d%H%M')

    print(f'{BLUE}========== 💪 开始打包Android 💪 =========={NC}')

    validate_parameters(args)
    version = extract_version()
    target_platform_str = get_target_platform_args(args.target_platform)
    split_abi_flag = '--split-per-abi' if split_abi and output_type == 'apk' else ''

    print(f'{YELLOW}┌---------------------------------------------------------------{NC}')
    print(f'{YELLOW}|    版本: {version}')
    print(f'{YELLOW}|    输出名称: {app_name}')
    print(f'{YELLOW}|    渠道: {channel}')
    print(f'{YELLOW}|    类型: {output_type}')
    print(f'{YELLOW}|    构建类型: {build_type}')
    print(f'{YELLOW}|    ABI拆分: {split_abi_flag}')
    print(f'{YELLOW}|    平台: --target-platform {target_platform_str}')
    print(f'{YELLOW}|    入口: {main_path}')
    print(f'{YELLOW}└---------------------------------------------------------------{NC}')

    build_command = ['flutter', 'build', output_type, f'--{build_type}']
    if split_abi_flag:
        build_command.append(split_abi_flag)
    build_command += ['--target-platform', target_platform_str]
    if channel:
        build_command += ['--dart-define', f'channel={channel}', '--android-project-arg', f'channel={channel}']
    build_command += ['-t', main_path]

    print(f'{BLUE}执行命令:{NC} {" ".join(build_command)}')
    try:
        subprocess.run(build_command, check=True)
    except subprocess.CalledProcessError:
        print(f'{RED}错误: 打包命令执行失败{NC}', file=sys.stderr)
        sys.exit(1)

    output_dir = f'app/android/{build_type}/'
    os.makedirs(output_dir, exist_ok=True)
    print(f'{BLUE}输出目录: {output_dir}{NC}')

    if output_type == 'apk':
        if split_abi:
            if args.target_platform >= 1:
                move_apk_file('armeabi-v7a', '32v', build_type, app_name, channel, version, current_date)
            if args.target_platform == 0 or args.target_platform >= 2:
                move_apk_file('arm64-v8a', '64v', build_type, app_name, channel, version, current_date)
            if args.target_platform >= 3:
                move_apk_file('x86_64', 'x86v', build_type, app_name, channel, version, current_date)
        else:
            move_apk_file('', '', build_type, app_name, channel, version, current_date)
    elif output_type == 'appbundle':
        src = f'build/app/outputs/bundle/{build_type}/app-{build_type}.aab'
        dest = f'{output_dir}{app_name}-{channel}-v{version}-{current_date}.aab'
        if os.path.isfile(src):
            os.replace(src, dest)
            print(f'已移动: {src} -> {dest}')
        else:
            print(f'{YELLOW}警告: 未找到AAB文件 {src}{NC}')

    print(f'{GREEN}========== ✅ 打包完成 ✅ =========={NC}')
    print(f'{GREEN}输出目录: {output_dir}{NC}')


if __name__ == '__main__':
    main()
