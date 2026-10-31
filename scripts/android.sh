#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_help() {
  echo -e "${GREEN}用法: $0 [选项]"
  echo -e "${GREEN}Flutter Android打包脚本"
  echo
  echo -e "${GREEN}选项:"
  echo -e "${GREEN}  -n app_name         应用名称 ${NC}(默认: 空)"
  echo -e "${GREEN}  -c channel          渠道名 ${NC}(默认: android)"
  echo -e "${GREEN}  -o output_type      输出类型 ${NC}[apk(default), appbundle, aar]"
  echo -e "${GREEN}  -t target_platform  目标平台 ${NC}[0:arm64, 1:arm, 2:arm+arm64, 3:arm+arm64+x64]"
  echo -e "${GREEN}  -b build_type       构建类型 ${NC}[release(default), profile, debug]"
  echo -e "${GREEN}  -p main_path        入口文件路径 ${NC}(默认: lib/main.dart)"
  echo -e "${GREEN}  -s                  不拆分ABI ${NC}(默认: 拆分)"
  echo -e "${GREEN}  -h                  显示帮助信息"
  echo
}

app_name=""
channel="android"
output_type="apk"
target_platform=2
build_type="release"
main_path="lib/main.dart"
split_abi=1  # 1:拆分ABI, 0:不拆分
current_date=$(date "+%Y%m%d%H%M")

# 每次执行都显示帮助信息
show_help

while getopts ":n:c:o:t:b:p:sh" opt; do
  case $opt in
    n) app_name="$OPTARG" ;;
    c) channel="$OPTARG" ;;
    o) output_type="$OPTARG" ;;
    t) target_platform=$OPTARG ;;
    b) build_type="$OPTARG" ;;
    p) main_path="$OPTARG" ;;
    s) split_abi=0 ;;
    h) exit 0 ;;
    :) echo -e "${RED}错误: 选项 -$OPTARG 需要参数${NC}" >&2; exit 1 ;;
    \?) echo -e "${RED}错误: 未知选项 -$OPTARG${NC}" >&2; exit 1 ;;
  esac
done

validate_parameters() {
  if ! [[ $output_type =~ ^(apk|appbundle|aar)$ ]]; then
    echo -e "${RED}错误: 输出类型必须是 apk, appbundle 或 aar${NC}" >&2; exit 1
  fi

  if ! [[ $target_platform =~ ^[0-3]$ ]]; then
    echo -e "${RED}错误: 目标平台必须是 0-3 之间的数字${NC}" >&2; exit 1
  fi

  if ! [[ $build_type =~ ^(release|profile|debug)$ ]]; then
    echo -e "${RED}错误: 构建类型必须是 release, profile 或 debug${NC}" >&2; exit 1
  fi

  [ -f "$main_path" ] || { echo -e "${RED}错误: 入口文件 $main_path 不存在${NC}" >&2; exit 1; }

  [ -d "android" ] || { echo -e "${RED}错误: android目录不存在，请确认在Flutter项目根目录执行此脚本${NC}" >&2; exit 1; }
}

extract_version() {
  local version
  version=$(awk '/^version: / {print $2; exit}' pubspec.yaml)
  [ -n "$version" ] || { echo -e "${RED}错误: 无法从 pubspec.yaml 提取版本号${NC}" >&2; exit 1; }
  echo "$version"
}

get_target_platform_args() {
  case "$1" in
    0) echo "android-arm64" ;;
    1) echo "android-arm" ;;
    2) echo "android-arm,android-arm64" ;;
    3) echo "android-arm,android-arm64,android-x64" ;;
  esac
}

move_apk_file() {
  local abi=$1
  local suffix=$2
  local src="build/app/outputs/flutter-apk/app${abi:+-$abi}-$build_type.apk"
  local dest="app/android/$build_type/${app_name}-${channel}-${suffix}${version}-${current_date}.apk"
  if [ -f "$src" ]; then
    mkdir -p "$(dirname "$dest")"
    mv -v "$src" "$dest"
  else
    echo -e "${YELLOW}警告: 未找到 $abi APK 文件 $src${NC}"
  fi
}

main() {
  echo -e "${BLUE}========== 💪 开始打包Android 💪 ==========${NC}"
  validate_parameters
  version=$(extract_version)

  local target_platform_str
  target_platform_str=$(get_target_platform_args "$target_platform")

  local split_abi_flag=""
  if [ "$split_abi" -eq 1 ] && [ "$output_type" = "apk" ]; then
    split_abi_flag="--split-per-abi"
  fi

  echo -e "
 ${YELLOW}┌---------------------------------------------------------------${NC}
 ${YELLOW}|    版本: $version
 ${YELLOW}|    输出名称: $app_name
 ${YELLOW}|    渠道: $channel
 ${YELLOW}|    类型: $output_type
 ${YELLOW}|    构建类型: $build_type
 ${YELLOW}|    ABI拆分: $split_abi_flag
 ${YELLOW}|    平台: --target-platform $target_platform_str
 ${YELLOW}|    入口: $main_path
 ${YELLOW}└---------------------------------------------------------------${NC}"

  local -a build_command=(flutter build "$output_type" "--$build_type")
  if [ -n "$split_abi_flag" ]; then
    build_command+=("$split_abi_flag")
  fi
  build_command+=("--target-platform" "$target_platform_str")
  if [ -n "$channel" ]; then
    build_command+=("--dart-define" "channel=$channel" "--android-project-arg" "channel=$channel")
  fi
  build_command+=("-t" "$main_path")

  echo -e "${BLUE}执行命令:${NC} ${build_command[*]}"
  "${build_command[@]}"

  local output_dir="app/android/$build_type/"
  mkdir -p "$output_dir"
  echo -e "${BLUE}输出目录: $output_dir${NC}"

  if [ "$output_type" = "apk" ]; then
    if [ "$split_abi" -eq 1 ]; then
      if [ "$target_platform" -ge 1 ]; then
        move_apk_file "armeabi-v7a" "32v"
      fi
      if [ "$target_platform" -eq 0 ] || [ "$target_platform" -ge 2 ]; then
        move_apk_file "arm64-v8a" "64v"
      fi
      if [ "$target_platform" -ge 3 ]; then
        move_apk_file "x86_64" "x86v"
      fi
    else
      move_apk_file "" ""
    fi
  elif [ "$output_type" = "appbundle" ]; then
    local src="build/app/outputs/bundle/$build_type/app-$build_type.aab"
    local dest="$output_dir${app_name}-${channel}-v${version}-${current_date}.aab"
    mv -v "$src" "$dest"
  fi

  echo -e "${GREEN}========== ✅ 打包完成 ✅ ==========${NC}"
  echo -e "${GREEN}输出目录: $output_dir${NC}"
}

main
