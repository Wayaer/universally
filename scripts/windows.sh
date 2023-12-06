#!/usr/bin/env bash

echo ""
echo "========== 💪 开始打包windows 💪 =========="

# -n appName app名字  [appName]
# -c channel 渠道名  [channel]
# -b buildType buildType [release,profile,debug]
# -p mainPath

outputName=""
mainPath="lib/main.dart"
channel="windows"
buildType="release"

while getopts ":n:c:m:b:p:" optname; do
  case "$optname" in
  "n")
    outputName="$OPTARG"
    ;;
  "c")
    channel="$OPTARG"
    ;;
  "b")
    buildType="$OPTARG"
    ;;
  "p")
    mainPath="$OPTARG"
    ;;
  *)
    echo "Unknown error while processing options"
    ;;
  esac
done

#获取版本号
version=$(grep "version:" pubspec.yaml)
version=${version#version: }

dartDefine=" --dart-define channel=$channel"
if [ "" == "$channel" ]; then
  dartDefine=""
fi

echo "
 -------------------------------------------------------------
 |    windows: $version,
 |    outputName: $outputName,
 |    channel: $channel,
 |    buildType: $buildType,
 |    mainPath: $mainPath
 --------------------------------------------------------------"

echo "flutter build windows --$buildType --analyze-size$dartDefine -t $mainPath"
# shellcheck disable=SC2086
flutter build windows --$buildType --analyze-size$dartDefine -t $mainPath

outputDir="app/windows/$buildType/"

mkdir -p "$outputDir"

echo ""
echo "😄 打包 $channel 的 $buildType 已完成 😄"

# shellcheck disable=SC2140
mv ./build/windows/x64/runner/"$buildType" ./"$outputDir"/"$outputName-$channel-v$version/"

echo ""
echo "========== 💪 windows 打包完成 💪 =========="
echo ""
