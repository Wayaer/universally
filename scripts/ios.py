#!/usr/bin/env python3
"""Flutter iOS 打包脚本。"""
import argparse
import os
import shutil
import subprocess
import sys
from datetime import datetime

RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'

EXPORT_METHODS = ('ad-hoc', 'app-store', 'development', 'enterprise')
BUILD_TYPES = ('release', 'profile', 'debug')


def show_help() -> None:
    """显示帮助信息"""
    print(f'{GREEN}===== Flutter iOS打包脚本使用说明 ====={NC}')
    print(f'{GREEN}用法:{NC} {sys.argv[0]} [选项]')
    print()
    print(f'{GREEN}选项:{NC}')
    print(f'{GREEN}  -n app_name        应用名称{NC} (默认: 空)')
    print(f'{GREEN}  -c channel         渠道名{NC} (默认: ios)')
    print(f'{GREEN}  -m export_method   导出方式{NC} [ad-hoc, app-store(default), development, enterprise]')
    print(f'{GREEN}  -b build_type      构建类型{NC} [release(default), profile, debug]')
    print(f'{GREEN}  -p main_path       入口文件路径{NC} (默认: lib/main.dart)')
    print(f'{GREEN}  -h                 仅显示帮助信息并退出{NC}')
    print()


def validate_parameters(args: argparse.Namespace) -> None:
    """验证输入参数"""
    if args.export_method not in EXPORT_METHODS:
        print(f'{RED}错误: 导出方式必须是 ad-hoc, app-store, development 或 enterprise{NC}', file=sys.stderr)
        sys.exit(1)

    if args.build_type not in BUILD_TYPES:
        print(f'{RED}错误: 构建类型必须是 release, profile 或 debug{NC}', file=sys.stderr)
        sys.exit(1)

    if not os.path.isfile(args.main_path):
        print(f'{RED}错误: 入口文件 {args.main_path} 不存在{NC}', file=sys.stderr)
        sys.exit(1)

    if not args.app_name:
        print(f'{YELLOW}警告: 应用名称为空，将影响输出文件命名{NC}')

    if not os.path.isdir('ios'):
        print(f'{RED}错误: ios目录不存在，请确认在Flutter项目根目录执行此脚本{NC}', file=sys.stderr)
        sys.exit(1)


def extract_version() -> str:
    """从 pubspec.yaml 提取版本号"""
    try:
        with open('pubspec.yaml', encoding='utf-8') as file:
            for line in file:
                if line.startswith('version: '):
                    return line.strip().split(' ')[1]
    except FileNotFoundError:
        print(f'{RED}错误: 未找到pubspec.yaml文件{NC}', file=sys.stderr)
        sys.exit(1)

    print(f'{RED}错误: 无法从 pubspec.yaml 提取版本号{NC}', file=sys.stderr)
    sys.exit(1)


def main() -> None:
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-n', dest='app_name', default='', help='应用名称')
    parser.add_argument('-c', dest='channel', default='ios', help='渠道名')
    parser.add_argument('-m', dest='export_method', default='app-store', help='导出方式')
    parser.add_argument('-b', dest='build_type', default='release', help='构建类型')
    parser.add_argument('-p', dest='main_path', default='lib/main.dart', help='入口文件路径')
    parser.add_argument('-h', action='store_true', dest='help', help='显示帮助信息')

    args = parser.parse_args()
    show_help()
    if args.help:
        sys.exit(0)

    print(f'{BLUE}========== 💪 开始打包iOS 💪 =========={NC}')
    validate_parameters(args)
    version = extract_version()
    current_date = datetime.now().strftime('%Y%m%d%H%M')

    print(f'{YELLOW}┌---------------------------------------------------------------{NC}')
    print(f'{YELLOW}|    版本: {version}{NC}')
    print(f'{YELLOW}|    输出名称: {args.app_name}{NC}')
    print(f'{YELLOW}|    渠道: {args.channel}{NC}')
    print(f'{YELLOW}|    导出方式: {args.export_method}{NC}')
    print(f'{YELLOW}|    构建类型: {args.build_type}{NC}')
    print(f'{YELLOW}|    入口: {args.main_path}{NC}')
    print(f'{YELLOW}└---------------------------------------------------------------{NC}')

    build_command = ['flutter', 'build', 'ipa', f'--{args.build_type}', '--analyze-size']
    build_command += ['--export-method', args.export_method]
    if args.channel:
        build_command += ['--dart-define', f'channel={args.channel}']
    build_command += ['-t', args.main_path]

    print(f'{BLUE}执行命令:{NC} {" ".join(build_command)}')
    try:
        subprocess.run(build_command, check=True)
    except subprocess.CalledProcessError:
        print(f'{RED}错误: 打包命令执行失败{NC}', file=sys.stderr)
        sys.exit(1)

    output_dir = f'app/ios/{args.build_type}/'
    os.makedirs(output_dir, exist_ok=True)
    print(f'{BLUE}输出目录: {output_dir}{NC}')

    src = f'build/ios/ipa/{args.app_name}.ipa'
    dest = f'{output_dir}{args.app_name}-{args.channel}-{args.export_method}-v{version}-{current_date}.ipa'

    if os.path.isfile(src):
        shutil.move(src, dest)
        print(f'{GREEN}已移动文件到: {dest}{NC}')
    else:
        print(f'{RED}错误: 未找到IPA文件 {src}{NC}', file=sys.stderr)
        sys.exit(1)

    print(f'{GREEN}========== ✅ iOS打包完成 ✅ =========={NC}')
    print(f'{GREEN}输出目录: {output_dir}{NC}')


if __name__ == '__main__':
    main()
