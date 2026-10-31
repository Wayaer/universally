#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_help() {
  echo -e "${GREEN}===== Flutter Windows打包脚本使用说明 =====${NC}"
  echo -e "${GREEN}用法:${NC} $0 [选项]"
  echo
  echo -e "${GREEN}选项:${NC}"
  echo -e "${GREEN}  -n app_name      应用名称${NC} (默认: 空)"
  echo -e "${GREEN}  -c channel       渠道名${NC} (默认: windows)"
  echo -e "${GREEN}  -b build_type    构建类型${NC} [release(default), profile, debug]"
  echo -e "${GREEN}  -p main_path     入口文件路径${NC} (默认: lib/main.dart)"
  echo -e "${GREEN}  -h               仅显示帮助信息并退出${NC}"
  echo
}

app_name=""
main_path="lib/main.dart"
channel="windows"
build_type="release"
current_date=$(date "+%Y%m%d%H%M")

while getopts ":n:c:b:p:h" opt; do
  case $opt in
    n) app_name="$OPTARG" ;;
    c) channel="$OPTARG" ;;
    b) build_type="$OPTARG" ;;
    p) main_path="$OPTARG" ;;
    h) show_help; exit 0 ;;
    :) echo -e "${RED}错误: 选项 -$OPTARG 需要参数${NC}" >&2; exit 1 ;;
    \?) echo -e "${RED}错误: 未知选项 -$OPTARG${NC}" >&2; exit 1 ;;
    *) echo -e "${RED}处理选项时发生未知错误${NC}" >&2; exit 1 ;;
  esac
done

show_help

validate_parameters() {
  if [ ! -d "windows" ]; then
    echo -e "${RED}错误: 未找到windows目录，请确认当前目录是Flutter项目根目录且已配置windows平台${NC}" >&2
    echo -e "${YELLOW}提示: 可以使用 'flutter create --platforms windows .' 命令添加windows平台支持${NC}" >&2
    exit 1
  fi

  if ! [[ $build_type =~ ^(release|profile|debug)$ ]]; then
    echo -e "${RED}错误: 构建类型必须是 release, profile 或 debug${NC}" >&2; exit 1
  fi

  [ -f "$main_path" ] || { echo -e "${RED}错误: 入口文件 $main_path 不存在${NC}" >&2; exit 1; }

  if [ -z "$app_name" ]; then
    echo -e "${YELLOW}警告: 应用名称为空，将影响输出文件命名${NC}"
  fi
}

extract_version() {
  local version
  version=$(awk '/^version: / {print $2; exit}' pubspec.yaml)
  [ -n "$version" ] || { echo -e "${RED}错误: 无法从 pubspec.yaml 提取版本号${NC}" >&2; exit 1; }
  echo "$version"
}

main() {
  echo -e "${BLUE}========== 💪 开始打包Windows 💪 ==========${NC}"
  validate_parameters
  version=$(extract_version)

  echo -e "
 ${YELLOW}┌---------------------------------------------------------------${NC}
 ${YELLOW}|    版本: $version${NC}
 ${YELLOW}|    输出名称: $app_name${NC}
 ${YELLOW}|    渠道: $channel${NC}
 ${YELLOW}|    构建类型: $build_type${NC}
 ${YELLOW}|    入口: $main_path${NC}
 ${YELLOW}└---------------------------------------------------------------${NC}"

  local -a build_command=(flutter build windows "--$build_type" --analyze-size)
  if [ -n "$channel" ]; then
    build_command+=("--dart-define" "channel=$channel")
  fi
  build_command+=("-t" "$main_path")

  echo -e "${BLUE}执行命令:${NC} ${build_command[*]}"
  "${build_command[@]}"

  local output_dir="app/windows/$build_type/"
  mkdir -p "$output_dir"
  echo -e "${BLUE}输出目录: $output_dir${NC}"

  local src="build/windows/x64/runner/$build_type"
  local dest="$output_dir${app_name}-${channel}-v${version}-${current_date}"

  if [ -d "$src" ]; then
    if [ -d "$dest" ]; then
      rm -rf "$dest"
      echo -e "${YELLOW}警告: 目标目录已存在，已删除旧版本${NC}"
    fi
    mv -v "$src" "$dest"
  else
    echo -e "${RED}错误: 未找到应用目录 $src${NC}" >&2; exit 1
  fi

  echo -e "${GREEN}========== ✅ Windows打包完成 ✅ ==========${NC}"
  echo -e "${GREEN}输出目录: $output_dir${NC}"
}

main
