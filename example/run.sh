#!/usr/bin/env bash

# 定义各平台脚本路径
ANDROID_SCRIPT="../scripts/android.sh"
IOS_SCRIPT="../scripts/ios.sh"
WEB_SCRIPT="../scripts/web.sh"
MACOS_SCRIPT="../scripts/macos.sh"
WINDOWS_SCRIPT="../scripts/windows.sh"

# 存储所有脚本路径的数组
ALL_SCRIPTS=(
    "$ANDROID_SCRIPT"
    "$IOS_SCRIPT"
    "$WEB_SCRIPT"
    "$MACOS_SCRIPT"
    "$WINDOWS_SCRIPT"
)

# 检查并添加脚本执行权限的函数
ensure_executable() {
    local script_path=$1
    if [ ! -f "$script_path" ]; then
        echo "错误：脚本文件 $script_path 不存在！"
        exit 1
    fi

    if [ ! -x "$script_path" ]; then
        echo "正在为脚本 $script_path 添加执行权限..."
        chmod +x "$script_path" || { echo "无法为 $script_path 添加执行权限！"; exit 1; }
    fi
}

echo "开始获取 packages 插件资源"
flutter packages get

# 检查获取资源是否成功
if [ $? -ne 0 ]; then
    echo "获取 packages 插件资源失败，终止执行"
    exit 1
fi

# 批量检查并添加所有脚本的执行权限
echo -e "\n正在检查所有平台脚本的执行权限..."
for script in "${ALL_SCRIPTS[@]}"; do
    ensure_executable "$script"
done

# 显示菜单
echo -e "\n请选择要执行的平台脚本："
echo "1 - Android"
echo "2 - iOS"
echo "3 - Web"
echo "4 - macOS"
echo "5 - Windows"
echo -n "请输入数字(1-5)："

# 读取用户输入
read -r choice

# 根据用户选择执行相应脚本
case $choice in
    1)
        echo "执行 Android 脚本..."
        "$ANDROID_SCRIPT"
        ;;
    2)
        echo "执行 iOS 脚本..."
        "$IOS_SCRIPT"
        ;;
    3)
        echo "执行 Web 脚本..."
        "$WEB_SCRIPT"
        ;;
    4)
        echo "执行 macOS 脚本..."
        "$MACOS_SCRIPT"
        ;;
    5)
        echo "执行 Windows 脚本..."
        "$WINDOWS_SCRIPT"
        ;;
    *)
        echo "无效的选择，请输入1到5之间的数字"
        exit 1
        ;;
esac

echo "脚本执行完成"
