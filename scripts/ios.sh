#!/usr/bin/env bash

echo ""
echo "========== 💪 开始打包iOS 💪 =========="

# -n appName app名字  [appName]
# -c channel 渠道名  [channel]
# -m exportMethodName  [ad-hoc,app-store(default),development,enterprise]
# -b buildType buildType [release,profile,debug]
# -p mainPath

outputName=""
mainPath="lib/main.dart"
channel="ios"
exportMethodName="app-store"
buildType="release"

while getopts ":n:c:m:b:p:" optname; do
  case "$optname" in
  "n")
    outputName="$OPTARG"
    ;;
  "c")
    channel="$OPTARG"
    ;;
  "m")
    exportMethodName="$OPTARG"
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
exportMethod=" --export-method $exportMethodName"

echo "
 -------------------------------------------------------------
 |    ios: $version,
 |    outputName: $outputName,
 |    channel: $channel,
 |    exportMethod: $exportMethod,
 |    buildType: $buildType,
 |    mainPath: $mainPath
 --------------------------------------------------------------"

echo "flutter build ipa --$buildType --analyze-size$exportMethod$dartDefine -t $mainPath"
# shellcheck disable=SC2086
flutter build ipa --$buildType --analyze-size$exportMethod$dartDefine -t $mainPath

outputDir="app/ios/$buildType/"

mkdir -p "$outputDir"

echo ""
echo "😄 打包 $channel 的 $exportMethodName $buildType 已完成 😄"

mv ./build/ios/ipa/"$outputName".ipa ./"$outputDir"/"$outputName-$channel-$exportMethodName-v$version""-$(date "+%Y%m%d%H%M")".ipa

echo ""
echo "========== 💪 iOS打包完成 💪 =========="
echo ""
