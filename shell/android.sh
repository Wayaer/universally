#!/usr/bin/env bash

echo ""
echo "========== 💪 开始打包Android 💪 =========="

#可选参数 按顺序传递
#[app名字,渠道名,输出apk或者aab,不拆分ABI，buildType]
#[[appName],[channel],[appbundle,apk(default)],[no-split],[release,profile,debug]]

#输出文件名字
outputName="$1"

#渠道 传递参数
channel=$2
# shellcheck disable=SC2236
if [ ! -n "$channel" ]; then
  channel=android
fi
dartDefine="--dart-define channel=$channel"
androidProjectArg="--android-project-arg channel=$channel"

#打包apk或者是bundle
#[appbundle] [apk]
outputType=$3
# shellcheck disable=SC2236
if [ ! -n "$outputType" ]; then
  outputType=apk
fi

#是否分割apk --split-per-abi
isSplitABI=$4
splitABI=
# shellcheck disable=SC2236
if [ ! -n "$isSplitABI" ] && [ $outputType == apk ]; then
  splitABI="--split-per-abi"
fi

#[release] [profile] [debug]
buildType=$5
# shellcheck disable=SC2236
if [ ! -n "$buildType" ]; then
  buildType=release
fi
#包含的abi
targetPlatform=" --target-platform android-arm,android-arm64 "

version=$(grep 'version:' pubspec.yaml)
version=${version#version: }

echo ""
echo "😄 [ $outputName android: $version = $outputType = $buildType = $channel ] 😄"

# shellcheck disable=SC2086
flutter build $outputType --$buildType $splitABI $targetPlatform $dartDefine $androidProjectArg -t lib/main.dart

outputDir="app/android/$buildType/"

mkdir -p "$outputDir"

echo ""
echo "😄 打包 $channel 的 $buildType 已完成 😄"

if [ "apk" == "$outputType" ]; then
  if [ "" == "$isSplitABI" ]; then
    mv ./build/app/outputs/flutter-apk/app-arm64-v8a-$buildType.apk ./$outputDir"$outputName-$channel-64v${version}.$(date "+%Y%m%d%H%M")".apk
    mv ./build/app/outputs/flutter-apk/app-armeabi-v7a-$buildType.apk ./$outputDir"$outputName-$channel-32v${version}.$(date "+%Y%m%d%H%M")".apk
    #    mv ./build/app/outputs/flutter-apk/app-x86_64-$buildType.apk ./$outputDir"$outputName-$channel-x86-64v${version}.$(date "+%Y%m%d%H%M")".apk
  else
    mv ./build/app/outputs/flutter-apk/app-$buildType.apk ./$outputDir"$outputName-$channel-v${version}.$(date "+%Y%m%d%H%M")".apk
  fi
elif [ "appbundle" == "$outputType" ]; then
  mv ./build/app/outputs/bundle/$buildType/app-$buildType.aab ./$outputDir"$outputName-$channel-v${version}.$(date "+%Y%m%d%H%M")".aab
fi

echo ""
echo "========== 💪 Android打包完成 💪 =========="
echo ""
