#!/usr/bin/env python3
import os
import re
import sys
import argparse
import subprocess
from datetime import datetime

# 颜色定义
class Colors:
    RED = '\033[0;31m'
    GREEN = '\033[0;32m'
    YELLOW = '\033[1;33m'
    BLUE = '\033[0;34m'
    NC = '\033[0m'  # 无颜色

def show_help(parser):
    """显示帮助信息"""
    print(f"{Colors.GREEN}用法: {sys.argv[0]} [选项]")
    print(f"{Colors.GREEN}Flutter Android打包脚本")
    print()
    print(f"{Colors.GREEN}选项:")
    parser.print_help()
    print(Colors.NC)

def validate_parameters(args):
    """验证输入参数"""
    # 验证输出类型
    if args.output_type not in ['apk', 'appbundle', 'aar']:
        print(f"{Colors.RED}错误: 输出类型必须是 apk, appbundle 或 aar{Colors.NC}", file=sys.stderr)
        sys.exit(1)

    # 验证目标平台
    if args.target_platform not in [0, 1, 2, 3]:
        print(f"{Colors.RED}错误: 目标平台必须是 0-3 之间的数字{Colors.NC}", file=sys.stderr)
        sys.exit(1)

    # 验证构建类型
    if args.build_type not in ['release', 'profile', 'debug']:
        print(f"{Colors.RED}错误: 构建类型必须是 release, profile 或 debug{Colors.NC}", file=sys.stderr)
        sys.exit(1)

    # 验证入口文件存在
    if not os.path.isfile(args.main_path):
        print(f"{Colors.RED}错误: 入口文件 {args.main_path} 不存在{Colors.NC}", file=sys.stderr)
        sys.exit(1)

    # 验证android目录存在
    if not os.path.isdir("android"):
        print(f"{Colors.RED}错误: android目录不存在，请确认在Flutter项目根目录执行此脚本{Colors.NC}", file=sys.stderr)
        sys.exit(1)

def extract_version():
    """从pubspec.yaml提取版本号"""
    try:
        with open("pubspec.yaml", "r", encoding="utf-8") as f:
            content = f.read()
            match = re.search(r'^version: (.*)$', content, re.MULTILINE)
            if match:
                return match.group(1)
            else:
                print(f"{Colors.RED}错误: 无法从 pubspec.yaml 提取版本号{Colors.NC}", file=sys.stderr)
                sys.exit(1)
    except FileNotFoundError:
        print(f"{Colors.RED}错误: 未找到 pubspec.yaml 文件{Colors.NC}", file=sys.stderr)
        sys.exit(1)

def get_target_platform_args(platform):
    """获取目标平台参数"""
    if platform == 0:
        return "android-arm64"
    elif platform == 1:
        return "android-arm"
    elif platform == 2:
        return "android-arm,android-arm64"
    elif platform == 3:
        return "android-arm,android-arm64,android-x64"
    return ""

def move_apk_file(abi, suffix, build_type, app_name, channel, version, current_date):
    """移动APK文件的辅助函数"""
    src = f"build/app/outputs/flutter-apk/app{'-' + abi if abi else ''}-{build_type}.apk"
    dest = f"app/android/{build_type}/{app_name}-{channel}-{suffix}{version}-{current_date}.apk"

    if os.path.isfile(src):
        os.makedirs(os.path.dirname(dest), exist_ok=True)
        os.rename(src, dest)
        print(f"已移动: {src} -> {dest}")
    else:
        print(f"{Colors.YELLOW}警告: 未找到 {abi} APK 文件 {src}{Colors.NC}")

def main():
    # 初始化参数解析器
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument('-n', '--app-name', default="", help='应用名称 (默认: 空)')
    parser.add_argument('-c', '--channel', default='android', help='渠道名 (默认: android)')
    parser.add_argument('-o', '--output-type', default='apk', help='输出类型 [apk(default), appbundle, aar]')
    parser.add_argument('-t', '--target-platform', type=int, default=2, help='目标平台 [0:arm64, 1:arm, 2:arm+arm64, 3:arm+arm64+x64]')
    parser.add_argument('-b', '--build-type', default='release', help='构建类型 [release(default), profile, debug]')
    parser.add_argument('-p', '--main-path', default='lib/main.dart', help='入口文件路径 (默认: lib/main.dart)')
    parser.add_argument('-s', '--no-split-abi', action='store_true', help='不拆分ABI (默认: 拆分)')
    parser.add_argument('-h', '--help', action='store_true', help='显示帮助信息')

    # 解析参数
    args = parser.parse_args()

    # 显示帮助信息
    show_help(parser)

    # 如果指定了-h参数，显示帮助后退出
    if args.help:
        sys.exit(0)

    # 初始化变量
    app_name = args.app_name
    channel = args.channel
    output_type = args.output_type
    target_platform = args.target_platform
    build_type = args.build_type
    main_path = args.main_path
    split_abi = 0 if args.no_split_abi else 1  # 1:拆分ABI, 0:不拆分
    current_date = datetime.now().strftime("%Y%m%d%H%M")

    print(f"{Colors.BLUE}========== 💪 开始打包Android 💪 =========={Colors.NC}")

    # 验证参数
    validate_parameters(args)

    # 提取版本号
    version = extract_version()

    # 获取目标平台参数
    target_platform_str = get_target_platform_args(target_platform)
    target_platform_args = f"--target-platform {target_platform_str}"

    # ABI拆分参数
    split_abi_flag = "--split-per-abi" if split_abi == 1 and output_type == "apk" else ""

    # 渠道参数
    channel_arguments = ""
    if channel:
        channel_arguments = f"--dart-define channel={channel} --android-project-arg channel={channel}"

    # 显示打包信息
    print(f"{Colors.YELLOW}┌---------------------------------------------------------------{Colors.NC}")
    print(f"{Colors.YELLOW}|    版本: {version}")
    print(f"{Colors.YELLOW}|    输出名称: {app_name}")
    print(f"{Colors.YELLOW}|    渠道: {channel}")
    print(f"{Colors.YELLOW}|    类型: {output_type}")
    print(f"{Colors.YELLOW}|    构建类型: {build_type}")
    print(f"{Colors.YELLOW}|    ABI拆分: {split_abi_flag}")
    print(f"{Colors.YELLOW}|    平台: {target_platform_args}")
    print(f"{Colors.YELLOW}|    入口: {main_path}")
    print(f"{Colors.YELLOW}└---------------------------------------------------------------{Colors.NC}")

    # 构建命令
    build_command = [
        "flutter", "build", output_type,
        f"--{build_type}",
        *split_abi_flag.split(),
        *target_platform_args.split(),
        *channel_arguments.split(),
        "-t", main_path
    ]

    # 过滤空参数
    build_command = [arg for arg in build_command if arg]

    # 执行打包命令
    print(f"{Colors.BLUE}执行命令:{Colors.NC} {' '.join(build_command)}")
    try:
        subprocess.run(build_command, check=True)
    except subprocess.CalledProcessError as e:
        print(f"{Colors.RED}错误: 打包命令执行失败: {e}{Colors.NC}", file=sys.stderr)
        sys.exit(1)

    # 准备输出目录
    output_dir = f"app/android/{build_type}/"
    os.makedirs(output_dir, exist_ok=True)
    print(f"{Colors.BLUE}输出目录: {output_dir}{Colors.NC}")

    # 移动打包产物
    if output_type == "apk":
        if split_abi == 1:
            if target_platform >= 1:
                move_apk_file("armeabi-v7a", "32v", build_type, app_name, channel, version, current_date)
            if target_platform == 0 or target_platform >= 2:
                move_apk_file("arm64-v8a", "64v", build_type, app_name, channel, version, current_date)
            if target_platform >= 3:
                move_apk_file("x86_64", "x86v", build_type, app_name, channel, version, current_date)
        else:
            move_apk_file("", "", build_type, app_name, channel, version, current_date)
    elif output_type == "appbundle":
        src = f"build/app/outputs/bundle/{build_type}/app-{build_type}.aab"
        dest = f"{output_dir}{app_name}-{channel}-v{version}-{current_date}.aab"
        if os.path.isfile(src):
            os.rename(src, dest)
            print(f"已移动: {src} -> {dest}")
        else:
            print(f"{Colors.YELLOW}警告: 未找到AAB文件 {src}{Colors.NC}")

    print(f"{Colors.GREEN}========== ✅ 打包完成 ✅ =========={Colors.NC}")
    print(f"{Colors.GREEN}输出目录: {output_dir}{Colors.NC}")

if __name__ == "__main__":
    main()
