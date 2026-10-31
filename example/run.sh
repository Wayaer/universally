#!/usr/bin/env bash

# 初始化 app_name 为空
app_name=""

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

# 从 pubspec.yaml 读取 app_name 的函数（修复版）
read_app_name_from_pubspec() {
    local pubspec_path="./pubspec.yaml"

    # 检查文件是否存在
    if [ ! -f "$pubspec_path" ]; then
        echo "错误：未找到 $pubspec_path 文件"
        return 1
    fi

    echo "正在从 $pubspec_path 读取 app_name..."

    # 使用更可靠的方式提取app_name，兼容各种格式
    # 匹配以app_name:开头的行，忽略前后空格，提取值并去除引号
    local extracted_name
    extracted_name=$(grep -E '^[[:space:]]*app_name:[[:space:]]*' "$pubspec_path" |
                   sed -E 's/^[[:space:]]*app_name:[[:space:]]*//' |
                   sed -E 's/^["'\''[:space:]]+//' |
                   sed -E 's/["'\''[:space:]]+$//')

    # 验证提取结果
    if [ -n "$extracted_name" ]; then
        app_name="$extracted_name"
        echo "成功从pubspec.yaml获取到app_name: $app_name"
        return 0
    else
        echo "警告：在pubspec.yaml中未找到有效的app_name配置"
        return 1
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

# 尝试从 pubspec.yaml 读取 app_name
read_app_name_from_pubspec

# 如果从 pubspec 未获取到 app_name，则提示用户输入
if [ -z "$app_name" ]; then
    echo -e "\n请输入应用名称（app_name）："
    read -r app_name

    # 检查用户输入是否为空
    if [ -z "$app_name" ]; then
        echo "错误：app_name 不能为空，请重新运行脚本并设置有效的应用名称"
        exit 1
    fi
fi

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

# 根据用户选择执行相应脚本，使用 -n 参数传递 app_name
case $choice in
    1)
        echo "执行 Android 脚本，应用名称: $app_name..."
        "$ANDROID_SCRIPT" -n "$app_name"
        ;;
    2)
        echo "执行 iOS 脚本，应用名称: $app_name..."
        "$IOS_SCRIPT" -n "$app_name"
        ;;
    3)
        echo "执行 Web 脚本，应用名称: $app_name..."
        "$WEB_SCRIPT"
        ;;
    4)
        echo "执行 macOS 脚本，应用名称: $app_name..."
        "$MACOS_SCRIPT" -n "$app_name"
        ;;
    5)
        echo "执行 Windows 脚本，应用名称: $app_name..."
        "$WINDOWS_SCRIPT" -n "$app_name"
        ;;
    *)
        echo "无效的选择，请输入1到5之间的数字"
        exit 1
        ;;
esac

echo "脚本执行完成"
