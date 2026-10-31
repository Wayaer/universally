#!/usr/bin/env bash
set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

show_help() {
  echo -e "${GREEN}===== Flutter Web打包脚本使用说明 =====${NC}"
  echo -e "${GREEN}用法:${NC} $0 [选项]"
  echo
  echo -e "${GREEN}选项:${NC}"
  echo -e "${GREEN}  -b build_type    构建类型${NC} [release(default), profile, debug]"
  echo -e "${GREEN}  -p main_path     入口文件路径${NC} (默认: lib/main.dart)"
  echo -e "${GREEN}  -c channel       渠道名${NC} (默认: web)"
  echo -e "${GREEN}  -h               仅显示帮助信息并退出${NC}"
  echo
}

build_type="release"
main_path="lib/main.dart"
channel="web"
current_date=$(date "+%Y%m%d%H%M")

while getopts ":b:p:c:h" opt; do
  case $opt in
    b) build_type="$OPTARG" ;;
    p) main_path="$OPTARG" ;;
    c) channel="$OPTARG" ;;
    h) show_help; exit 0 ;;
    :) echo -e "${RED}错误: 选项 -$OPTARG 需要参数${NC}" >&2; exit 1 ;;
    \?) echo -e "${RED}错误: 未知选项 -$OPTARG${NC}" >&2; exit 1 ;;
    *) echo -e "${RED}处理选项时发生未知错误${NC}" >&2; exit 1 ;;
  esac
done

show_help

validate_parameters() {
  if ! [[ $build_type =~ ^(release|profile|debug)$ ]]; then
    echo -e "${RED}错误: 构建类型必须是 release, profile 或 debug${NC}" >&2; exit 1
  fi

  [ -f "$main_path" ] || { echo -e "${RED}错误: 入口文件 $main_path 不存在${NC}" >&2; exit 1; }

  [ -f "pubspec.yaml" ] || { echo -e "${RED}错误: 当前目录不是Flutter项目（未找到pubspec.yaml）${NC}" >&2; exit 1; }
}

extract_version() {
  local version
  version=$(awk '/^version: / {print $2; exit}' pubspec.yaml)
  if [ -z "$version" ]; then
    echo -e "${YELLOW}警告: 无法从 pubspec.yaml 提取版本号${NC}"
    echo "unknown"
    return
  fi
  echo "$version"
}

main() {
  echo -e "${BLUE}========== 💪 开始打包Web 💪 ==========${NC}"
  validate_parameters
  version=$(extract_version)

  echo -e "
 ${YELLOW}┌---------------------------------------------------------------${NC}
 ${YELLOW}|    版本: $version
 ${YELLOW}|    渠道: $channel
 ${YELLOW}|    构建类型: $build_type
 ${YELLOW}|    入口: $main_path
 ${YELLOW}└---------------------------------------------------------------${NC}"

  echo -e "${BLUE}开始获取 packages 插件资源...${NC}"
  if ! flutter packages get; then
    echo -e "${RED}错误: 获取插件资源失败${NC}" >&2; exit 1
  fi
  echo -e "${GREEN}插件资源获取完成${NC}"

  echo -e "${BLUE}检查并启用web平台...${NC}"
  if ! flutter config --enable-web; then
    echo -e "${YELLOW}警告: 启用web平台时出现问题，尝试继续...${NC}"
  fi

  echo -e "${BLUE}开始构建 Web 应用...${NC}"
  local -a build_command=(flutter build web "--$build_type")
  if [ -n "$channel" ]; then
    build_command+=("--dart-define" "channel=$channel")
  fi
  build_command+=("-t" "$main_path")

  echo -e "${BLUE}执行命令:${NC} ${build_command[*]}"
  "${build_command[@]}"

  echo -e "${BLUE}验证构建结果...${NC}"
  if [ ! -d "build/web" ]; then
    echo -e "${RED}错误: 构建目录 build/web 不存在${NC}" >&2; exit 1
  fi

  if [ ! -f "build/web/index.html" ]; then
    echo -e "${RED}错误: 缺少 index.html 文件，构建可能不完整${NC}" >&2; exit 1
  fi

  echo -e "${GREEN}构建结果验证通过，index.html 存在${NC}"

  local versioned_dir="app/web/version/${version}-${current_date}"
  local web_dir="app/web/web"

  echo -e "${BLUE}处理构建结果...${NC}"
  mkdir -p "$(dirname "$versioned_dir")"
  mkdir -p "$(dirname "$web_dir")"

  cp -R "build/web" "$versioned_dir" || { echo -e "${RED}错误: 复制到版本目录失败${NC}" >&2; exit 1; }
  echo -e "${GREEN}已生成版本化目录: $versioned_dir${NC}"

  cp -R "build/web" "$web_dir" || { echo -e "${RED}错误: 复制到web目录失败${NC}" >&2; exit 1; }
  echo -e "${GREEN}已生成web目录: $web_dir${NC}"

  echo -e "${GREEN}========== ✅ Web打包完成 ✅ ==========${NC}"
  echo -e "${GREEN}版本时间目录: $(readlink -f "$versioned_dir")${NC}"
  echo -e "${GREEN}Web目录: $(readlink -f "$web_dir")${NC}"
}

main
