#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess
import shutil
from datetime import datetime

# 颜色定义
RED = '\033[0;31m'
GREEN = '\033[0;32m'
YELLOW = '\033[1;33m'
BLUE = '\033[0;34m'
NC = '\033[0m'

def show_help():
    print(f"{GREEN}===== Flutter Web打包脚本使用说明 ====={NC}")
    print(f"{GREEN}用法:{NC} {sys.argv[0]} [选项]")
    print()
    print(f"{GREEN}选项:{NC}")
    print(f"{GREEN}  -b build_type    构建类型{NC} [release(default), profile, debug]")
    print(f"{GREEN}  -p main_path     入口文件路径{NC} (默认: lib/main.dart)")
    print(f"{GREEN}  -c channel       渠道名{NC} (默认: web)")
    print(f"{GREEN}  -h               仅显示帮助信息并退出{NC}")
    print()

def validate_parameters(args):
    # 验证构建类型
    if args.build_type not in ["release", "profile", "debug"]:
        print(f"{RED}错误: 构建类型必须是 release, profile 或 debug{NC}", file=sys.stderr)
        sys.exit(1)

    # 验证入口文件存在
    if not os.path.isfile(args.main_path):
        print(f"{RED}错误: 入口文件 {args.main_path} 不存在{NC}", file=sys.stderr)
        sys.exit(1)

    # 验证Flutter环境
    try:
        subprocess.run("flutter --version", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    except subprocess.CalledProcessError:
        print(f"{RED}错误: 未找到flutter命令，请确保Flutter已正确安装并添加到PATH中{NC}", file=sys.stderr)
        sys.exit(1)

    # 验证当前目录是Flutter项目
    if not os.path.isfile("pubspec.yaml"):
        print(f"{RED}错误: 当前目录不是Flutter项目（未找到pubspec.yaml）{NC}", file=sys.stderr)
        sys.exit(1)

def extract_version():
    try:
        with open("pubspec.yaml", "r", encoding="utf-8") as f:
            for line in f:
                if line.startswith("version: "):
                    return line.strip().split(" ")[1]
        print(f"{YELLOW}警告: 无法从 pubspec.yaml 提取版本号{NC}")
        return "unknown"
    except FileNotFoundError:
        print(f"{YELLOW}警告: 未找到pubspec.yaml文件，版本号未知{NC}")
        return "unknown"

def main():
    parser = argparse.ArgumentParser(add_help=False)
    parser.add_argument("-b", dest="build_type", default="release", help="构建类型")
    parser.add_argument("-p", dest="main_path", default="lib/main.dart", help="入口文件路径")
    parser.add_argument("-c", dest="channel", default="web", help="渠道名")
    parser.add_argument("-h", action="store_true", dest="help", help="显示帮助信息")

    args = parser.parse_args()

    # 显示帮助信息
    show_help()

    if args.help:
        sys.exit(0)

    print(f"{BLUE}========== 💪 开始打包Web 💪 =========={NC}")
    validate_parameters(args)
    version = extract_version()
    current_date = datetime.now().strftime("%Y%m%d%H%M")

    # 构建渠道参数
    dart_define = f"--dart-define channel={args.channel}" if args.channel else ""

    # 显示打包信息
    print(f"""
 {YELLOW}┌---------------------------------------------------------------{NC}
 {YELLOW}|    版本: {version}
 {YELLOW}|    渠道: {args.channel}
 {YELLOW}|    构建类型: {args.build_type}
 {YELLOW}|    入口: {args.main_path}
 {YELLOW}└---------------------------------------------------------------{NC}""")

    # 获取依赖包
    print(f"{BLUE}开始获取 packages 插件资源...{NC}")
    try:
        subprocess.run("flutter packages get", shell=True, check=True)
        print(f"{GREEN}插件资源获取完成{NC}")
    except subprocess.CalledProcessError:
        print(f"{RED}错误: 获取插件资源失败{NC}", file=sys.stderr)
        sys.exit(1)

    # 确保web平台已启用
    print(f"{BLUE}检查并启用web平台...{NC}")
    try:
        subprocess.run("flutter config --enable-web", shell=True, check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    except subprocess.CalledProcessError:
        print(f"{YELLOW}警告: 启用web平台时出现问题，尝试继续...{NC}")

    # 执行构建命令
    print(f"{BLUE}开始构建 Web 应用...{NC}")
    build_command = f"flutter build web --{args.build_type} {dart_define} -t {args.main_path}"
    print(f"{BLUE}执行命令:{NC} {build_command}")

    try:
        subprocess.run(build_command, shell=True, check=True)
    except subprocess.CalledProcessError:
        print(f"{RED}错误: Flutter Web构建失败{NC}", file=sys.stderr)
        sys.exit(1)

    # 验证构建结果
    print(f"{BLUE}验证构建结果...{NC}")
    if not os.path.isdir("build/web"):
        print(f"{RED}错误: 构建目录 build/web 不存在{NC}", file=sys.stderr)
        sys.exit(1)

    if not os.path.isfile("build/web/index.html"):
        print(f"{RED}错误: 缺少 index.html 文件，构建可能不完整{NC}", file=sys.stderr)
        sys.exit(1)

    print(f"{GREEN}构建结果验证通过，index.html 存在{NC}")

    # 定义两个目标目录
    versioned_dir = f"app/web/version/{version}-{current_date}"
    web_dir = "app/web/web"

    # 处理构建结果
    print(f"{BLUE}处理构建结果...{NC}")

    # 确保目标目录的父目录存在
    os.makedirs(os.path.dirname(versioned_dir), exist_ok=True)
    os.makedirs(os.path.dirname(web_dir), exist_ok=True)

    # 复制第一份到版本-时间命名的目录
    try:
        if os.path.exists(versioned_dir):
            shutil.rmtree(versioned_dir)
        shutil.copytree("build/web", versioned_dir)
        print(f"{GREEN}已生成版本化目录: {versioned_dir}{NC}")
    except Exception as e:
        print(f"{RED}错误: 复制到版本目录失败: {str(e)}{NC}", file=sys.stderr)
        sys.exit(1)

    # 复制第二份到web目录
    try:
        if os.path.exists(web_dir):
            shutil.rmtree(web_dir)
        shutil.copytree("build/web", web_dir)
        print(f"{GREEN}已生成web目录: {web_dir}{NC}")
    except Exception as e:
        print(f"{RED}错误: 复制到web目录失败: {str(e)}{NC}", file=sys.stderr)
        sys.exit(1)

    print(f"{GREEN}========== ✅ Web打包完成 ✅ =========={NC}")
    print(f"{GREEN}版本时间目录: {os.path.abspath(versioned_dir)}{NC}")
    print(f"{GREEN}Web目录: {os.path.abspath(web_dir)}{NC}")

if __name__ == "__main__":
    main()