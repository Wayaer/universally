#!/usr/bin/env bash

echo ""
echo "========== 💪 开始打包iOS 💪 =========="

#可选参数 按顺序传递
#[app名字,渠道名,exportMethod,buildType]
#[[appName],[channel],[ad-hoc,app-store(default),development,enterprise],[release,profile,debug]]

#输出文件名字
outputName="$1"

#渠道 传递参数
channel=$2
# shellcheck disable=SC2236
if [ ! -n "$channel" ]; then
  channel="ios"
fi
dartDefine=" --dart-define channel=$channel "

# export_method
exportMethodName=$3
# shellcheck disable=SC2236
if [ ! -n "$exportMethodName" ]; then
  exportMethodName=app-store
fi
exportMethod=" --export-method $exportMethodName"

#[release] [profile] [debug]
buildType=$4
# shellcheck disable=SC2236
if [ ! -n "$buildType" ]; then
  buildType=release
fi

#获取版本号
version=$(grep "version:" pubspec.yaml)
version=${version#version: }

echo ""
echo "😄 [ $outputName ios: $version = $buildType = $exportMethodName = $channel ] 😄"

# shellcheck disable=SC2086
flutter build ipa --$buildType --analyze-size "$exportMethod" "$dartDefine" -t lib/main.dart

outputDir="app/ios/$buildType/"

mkdir -p "$outputDir"

echo ""
echo "😄 打包 $channel 的 $exportMethodName $buildType 已完成 😄"

mv ./build/ios/ipa/"$outputName".ipa ./$outputDir/"$outputName$exportMethodName-v$version"".$(date "+%Y%m%d%H%M")".ipa

echo ""
echo "========== 💪 iOS打包完成 💪 =========="
echo ""
