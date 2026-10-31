#!/usr/bin/env python3
import os
import sys
import subprocess
import re

# 定义各平台脚本路径
ANDROID_SCRIPT = "../scripts/android.py"
IOS_SCRIPT = "../scripts/ios.py"
WEB_SCRIPT = "../scripts/web.py"
MACOS_SCRIPT = "../scripts/macos.py"
WINDOWS_SCRIPT = "../scripts/windows.py"

# 存储所有脚本路径的数组
ALL_SCRIPTS = [
    ANDROID_SCRIPT,
    IOS_SCRIPT,
    WEB_SCRIPT,
    MACOS_SCRIPT,
    WINDOWS_SCRIPT
]

def ensure_executable(script_path):
    """检查并确保脚本具有执行权限"""
    if not os.path.isfile(script_path):
        print(f"错误：脚本文件 {script_path} 不存在！")
        sys.exit(1)

    # 在Windows上不需要检查执行权限
    if sys.platform != "win32":
        # 检查文件是否可执行
        if not os.access(script_path, os.X_OK):
            print(f"正在为脚本 {script_path} 添加执行权限...")
            try:
                subprocess.run(["chmod", "+x", script_path], check=True)
            except subprocess.CalledProcessError:
                print(f"无法为 {script_path} 添加执行权限！")
                sys.exit(1)

def read_app_name_from_pubspec():
    """从pubspec.yaml读取app_name"""
    pubspec_path = "./pubspec.yaml"

    if not os.path.isfile(pubspec_path):
        print(f"错误：未找到 {pubspec_path} 文件")
        return None

    print(f"正在从 {pubspec_path} 读取 app_name...")

    try:
        with open(pubspec_path, "r", encoding="utf-8") as f:
            content = f.read()

            # 使用正则表达式提取app_name，兼容各种格式
            match = re.search(r'^[ \t]*app_name[ \t]*:[ \t]*(["\']?)(.*?)\1[ \t]*$',
                             content, re.MULTILINE)

            if match and match.group(2).strip():
                app_name = match.group(2).strip()
                print(f"成功从pubspec.yaml获取到app_name: {app_name}")
                return app_name
            else:
                print("警告：在pubspec.yaml中未找到有效的app_name配置")
                return None
    except Exception as e:
        print(f"读取pubspec.yaml时出错: {str(e)}")
        return None

def main():
    """主函数"""
    print("开始获取 packages 插件资源")
    try:
        subprocess.run(["flutter", "packages", "get"], check=True)
    except subprocess.CalledProcessError:
        print("获取 packages 插件资源失败，终止执行")
        sys.exit(1)

    # 批量检查并添加所有脚本的执行权限
    print("\n正在检查所有平台脚本的执行权限...")
    for script in ALL_SCRIPTS:
        ensure_executable(script)

    # 尝试从 pubspec.yaml 读取 app_name
    app_name = read_app_name_from_pubspec()

    # 如果从 pubspec 未获取到 app_name，则提示用户输入
    if not app_name:
        while True:
            app_name = input("\n请输入应用名称（app_name）：").strip()
            if app_name:
                break
            print("错误：app_name 不能为空，请重新输入")

    # 显示菜单
    print("\n请选择要执行的平台脚本：")
    print("1 - Android")
    print("2 - iOS")
    print("3 - Web")
    print("4 - macOS")
    print("5 - Windows")

    # 读取用户输入
    while True:
        choice = input("请输入数字(1-5)：").strip()
        if choice in ["1", "2", "3", "4", "5"]:
            break
        print("无效的选择，请输入1到5之间的数字")

    # 根据用户选择执行相应脚本，使用 -n 参数传递 app_name
    try:
        if choice == "1":
            print(f"执行 Android 脚本，应用名称: {app_name}...")
            subprocess.run(["python3", ANDROID_SCRIPT, "-n", app_name], check=True)
        elif choice == "2":
            print(f"执行 iOS 脚本，应用名称: {app_name}...")
            subprocess.run(["python3", IOS_SCRIPT, "-n", app_name], check=True)
        elif choice == "3":
            print(f"执行 Web 脚本，应用名称: {app_name}...")
            subprocess.run(["python3", WEB_SCRIPT], check=True)
        elif choice == "4":
            print(f"执行 macOS 脚本，应用名称: {app_name}...")
            subprocess.run(["python3", MACOS_SCRIPT, "-n", app_name], check=True)
        elif choice == "5":
            print(f"执行 Windows 脚本，应用名称: {app_name}...")
            subprocess.run(["python3", WINDOWS_SCRIPT, "-n", app_name], check=True)
    except subprocess.CalledProcessError as e:
        print(f"执行脚本时出错: {str(e)}")
        sys.exit(1)

    print("脚本执行完成")

if __name__ == "__main__":
    main()
