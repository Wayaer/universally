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
  echo -e "${GREEN}===== Flutter Web打包脚本使用说明 =====${NC}"
  echo -e "${GREEN}用法:${NC} $0 [选项]"
  echo
  echo -e "${GREEN}选项:${NC}"
  echo -e "  -b build_type    ${GREEN}构建类型${NC} [release(default), profile, debug]"
  echo -e "  -p main_path     ${GREEN}入口文件路径${NC} (默认: lib/main.dart)"
  echo -e "  -c channel       ${GREEN}渠道名${NC} (默认: web)"
  echo -e "  -h               ${GREEN}仅显示帮助信息并退出${NC}"
  echo
}

# 初始化参数
build_type="release"
main_path="lib/main.dart"
channel="web"
only_help=0
current_date=$(date "+%Y%m%d%H%M")

# 解析参数
while getopts ":b:p:c:h" opt; do
  case $opt in
    b) build_type="$OPTARG" ;;
    p) main_path="$OPTARG" ;;
    c) channel="$OPTARG" ;;
    h) only_help=1; show_help; exit 0 ;;
    :) echo -e "${RED}错误: 选项 -$OPTARG 需要参数${NC}" >&2; exit 1 ;;
    \?) echo -e "${RED}错误: 未知选项 -$OPTARG${NC}" >&2; exit 1 ;;
    *) echo -e "${RED}处理选项时发生未知错误${NC}" >&2; exit 1 ;;
  esac
done

# 显示帮助信息
show_help

# 如果仅需要帮助信息则退出
if [ "$only_help" -eq 1 ]; then
  exit 0
fi

# 参数验证
validate_parameters() {
  # 验证构建类型
  if ! [[ $build_type =~ ^(release|profile|debug)$ ]]; then
    echo -e "${RED}错误: 构建类型必须是 release, profile 或 debug${NC}" >&2; exit 1
  fi

  # 验证入口文件存在
  [ -f "$main_path" ] || { echo -e "${RED}错误: 入口文件 $main_path 不存在${NC}" >&2; exit 1; }
}

# 提取版本号
extract_version() {
  version=$(awk '/^version: / {print $2; exit}' pubspec.yaml)
  [ -n "$version" ] || { echo -e "${YELLOW}警告: 无法从 pubspec.yaml 提取版本号${NC}"; echo "unknown"; return; }
  echo "$version"
}

# 主执行函数
main() {
  echo -e "\n${BLUE}========== 💪 开始打包Web 💪 ==========${NC}"
  validate_parameters
  version=$(extract_version)

  # 构建渠道参数
  dart_define=""
  if [ -n "$channel" ]; then
    dart_define="--dart-define channel=$channel"
  fi

  # 显示打包信息
  echo -e "
 ${YELLOW}┌---------------------------------------------------------------${NC}
 ${YELLOW}|    版本: $version
 ${YELLOW}|    渠道: $channel
 ${YELLOW}|    构建类型: $build_type
 ${YELLOW}|    入口: $main_path
 ${YELLOW}└---------------------------------------------------------------${NC}"

  # 清理旧版本
  echo -e "\n${BLUE}清理旧版本文件...${NC}"
  rm -rf "app/web"
  echo -e "${GREEN}旧版本文件清理完成${NC}"

  # 获取依赖包
  echo -e "\n${BLUE}开始获取 packages 插件资源...${NC}"
  flutter packages get
  echo -e "${GREEN}插件资源获取完成${NC}"

  # 执行构建命令
  echo -e "\n${BLUE}开始构建 Web 应用...${NC}"
  build_command="flutter build web --$build_type $dart_define -t $main_path"
  echo -e "${BLUE}执行命令:${NC} $build_command"
  eval "$build_command"

  # 准备输出目录
  output_dir="app/web"
  mkdir -p "$output_dir"

  # 移动构建产物
  echo -e "\n${BLUE}移动构建产物...${NC}"
  if [ -d "build/web" ]; then
    mv -v "build/web" "$output_dir"
    # 重命名主目录以包含版本信息
    mv -v "$output_dir" "${output_dir}-${channel}-v${version}-${current_date}"
    ln -sfn "${output_dir}-${channel}-v${version}-${current_date}" "$output_dir"
    echo -e "${GREEN}产物移动完成${NC}"
  else
    echo -e "${RED}错误: 未找到Web构建产物目录 build/web${NC}" >&2; exit 1
  fi

  echo -e "\n${GREEN}========== ✅ Web打包完成 ✅ ==========${NC}"
  echo -e "${GREEN}输出目录: $(readlink -f "$output_dir")${NC}\n"
}

# 启动主函数
main
