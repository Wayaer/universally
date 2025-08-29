#!/usr/bin/env bash
set -euo pipefail

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# 显示帮助信息
show_help() {
  echo -e "${GREEN}用法: $0 [选项]"
  echo -e "${GREEN}Flutter HarmonyOS打包脚本"
  echo
  echo -e "${GREEN}选项:"
  echo -e "${GREEN}  -n app_name         应用名称 ${NC}(默认: 空)"
  echo -e "${GREEN}  -c channel          渠道名 ${NC}(默认: ohos)"
  echo -e "${GREEN}  -o output_type      输出类型 ${NC}[app(default), hap, har, hsp]"
  echo -e "${GREEN}  -t target_platform  目标平台 ${NC}[0:ohos-arm64, 1:ohos-arm, 2:ohos-x64, 3:ohos-arm+arm64+x64]"
  echo -e "${GREEN}  -b build_type       构建类型 ${NC}[release(default), debug]"
  echo -e "${GREEN}  -p main_path        入口文件路径 ${NC}(默认: lib/main.dart)"
  echo -e "${GREEN}  -h                  显示帮助信息"
  echo
}

# 初始化参数
app_name=""
channel="ohos"
output_type="app"  # 默认值为app
target_platform=0
build_type="release"
main_path="lib/main.dart"
current_date=$(date "+%Y%m%d%H%M")

# 显示帮助信息
show_help

# 解析参数
while getopts ":n:c:o:t:b:p:h" opt; do
  case $opt in
    n) app_name="$OPTARG" ;;
    c) channel="$OPTARG" ;;
    o) output_type="$OPTARG" ;;
    t) target_platform=$OPTARG ;;
    b) build_type="$OPTARG" ;;
    p) main_path="$OPTARG" ;;
    h) exit 0 ;;
    :) echo -e "${RED}错误: 选项 -$OPTARG 需要参数${NC}" >&2; exit 1 ;;
    \?) echo -e "${RED}错误: 未知选项 -$OPTARG${NC}" >&2; exit 1 ;;
  esac
done

# 参数验证
validate_parameters() {
  if ! [[ $output_type =~ ^(app|hap|har|hsp)$ ]]; then
    echo -e "${RED}错误: 输出类型必须是 app, hap, har 或 hsp${NC}" >&2; exit 1;
  fi

  if ! [[ $target_platform =~ ^[0-3]$ ]]; then
    echo -e "${RED}错误: 目标平台必须是 0-3 之间的数字${NC}" >&2; exit 1;
  fi

  if ! [[ $build_type =~ ^(release|debug)$ ]]; then
    echo -e "${RED}错误: 构建类型必须是 release 或 debug${NC}" >&2; exit 1;
  fi

  [ -f "$main_path" ] || { echo -e "${RED}错误: 入口文件 $main_path 不存在${NC}" >&2; exit 1; }

  [ -d "ohos" ] || { echo -e "${RED}错误: ohos目录不存在，请确认在Flutter项目根目录执行此脚本${NC}" >&2; exit 1; }
}

# 提取版本号
extract_version() {
  version=$(awk '/^version: / {print $2; exit}' pubspec.yaml)
  [ -n "$version" ] || { echo -e "${RED}错误: 无法从 pubspec.yaml 提取版本号${NC}" >&2; exit 1; }
  echo "$version"
}

# 获取目标平台参数转换
get_target_platform_args() {
  local platform=$1
  if [ "$platform" -eq 0 ]; then
    echo "ohos-arm64"
  elif [ "$platform" -eq 1 ]; then
    echo "ohos-arm"
  elif [ "$platform" -eq 2 ]; then
    echo "ohos-x64"
  elif [ "$platform" -eq 3 ]; then
    echo "ohos-arm,ohos-arm64,ohos-x64"
  fi
}

# 移动输出文件的辅助函数（支持通配符匹配和unsigned标识保留）
move_output_file() {
  local src_pattern=$1
  local base_dest=$2
  local ext=$3

  # 获取匹配的文件列表
  local files=($src_pattern)

  # 检查是否有匹配的文件
  if [ ${#files[@]} -eq 0 ] || [ ! -f "${files[0]}" ]; then
    echo -e "${YELLOW}警告: 未找到匹配 $src_pattern 的文件${NC}"
    return 1
  fi

  # 获取第一个匹配文件的文件名
  local filename=$(basename "${files[0]}")

  # 检查文件名是否包含unsigned
  local unsigned_suffix=""
  if [[ $filename == *unsigned* ]]; then
    unsigned_suffix="-unsigned"
  fi

  # 构建最终目标文件名
  local dest="${base_dest}${unsigned_suffix}.${ext}"

  # 移动文件
  mv -v "${files[0]}" "$dest"
  return 0
}

# 主执行函数
main() {
  echo -e "${BLUE}========== 💪 开始打包HarmonyOS 💪 ==========${NC}"
  validate_parameters
  version=$(extract_version)

  target_platform_str=$(get_target_platform_args "$target_platform")

  channel_arguments=""
  if [ -n "$channel" ]; then
    channel_arguments="--dart-define channel=$channel"
  fi

  target_platform_args="--target-platform $target_platform_str"

  echo -e "
 ${YELLOW}┌---------------------------------------------------------------${NC}
 ${YELLOW}|    版本: $version
 ${YELLOW}|    输出名称: $app_name
 ${YELLOW}|    渠道: $channel
 ${YELLOW}|    类型: $output_type
 ${YELLOW}|    构建类型: $build_type
 ${YELLOW}|    目标平台: $target_platform_str
 ${YELLOW}|    入口: $main_path
 ${YELLOW}└---------------------------------------------------------------${NC}"

  build_command="flutter build $output_type --$build_type $channel_arguments $target_platform_args -t $main_path"
  echo -e "${BLUE}执行命令:${NC} $build_command"
  eval "$build_command"

  output_dir="app/ohos/$build_type/"
  mkdir -p "$output_dir"
  echo -e "${BLUE}输出目录: $output_dir${NC}"

  # 统一路径格式 build/ohos/${output_type}/*.${output_type}
  src_pattern="build/ohos/${output_type}/*.${output_type}"

  # 构建基础目标文件名（不含后缀和unsigned标识）
  base_dest_name="${app_name}-${channel}-v${version}-${current_date}"
  full_base_dest="${output_dir}${base_dest_name}"

  # 移动文件并处理unsigned标识
  move_output_file "$src_pattern" "$full_base_dest" "$output_type"

  echo -e "${GREEN}========== ✅ 打包完成 ✅ ==========${NC}"
  echo -e "${GREEN}输出目录: $output_dir${NC}"
}

# 启动主函数
main
