#!/usr/bin/env bash

echo ""
echo "========== 💪 开始打包Android 💪 =========="

# -n appName app名字  [appName]
# -c channel 渠道名  [channel]
# -o outputType 输出apk或者aab,appbundle,  [appbundle,apk(default),aar]
# -t targetPlatform [1,2,3]
# -b buildType buildType [release,profile,debug]
# -p mainPath
# -s split 拆分ABI [0,1(默认为true)]

outputName=""
channel="android"
outputType="apk"
targetPlatform=2
buildType="release"
mainPath="lib/main.dart"
split=1

while getopts ":n:c:o:t:b:p:s" optname; do
  case "$optname" in
  "n")
    outputName="$OPTARG"
    ;;
  "c")
    channel="$OPTARG"
    ;;
  "o")
    outputType="$OPTARG"
    ;;
  "t")
    targetPlatform=$OPTARG
    ;;
  "b")
    buildType=$OPTARG
    ;;
  "p")
    mainPath="$OPTARG"
    ;;
  "s")
    split=0
    ;;
  *)
    echo "Unknown error while processing options"
    ;;
  esac
done
targetPlatformStr=""
if [ 0 == "$targetPlatform" ]; then
  targetPlatformStr=" --target-platform android-arm64"
elif [ 1 == "$targetPlatform" ]; then
  targetPlatformStr=" --target-platform android-arm"
elif [ 2 == "$targetPlatform" ]; then
  targetPlatformStr=" --target-platform android-arm,android-arm64"
else
  targetPlatformStr=""
fi
splitABI=""
if [ 1 == "$split" ] && [ "apk" == "$outputType" ]; then
  splitABI=" --split-per-abi"
fi
version=$(grep 'version:' pubspec.yaml)
version=${version#version: }

echo "
 -------------------------------------------------------------
 |    android: $version,
 |    outputName: $outputName,
 |    channel: $channel,
 |    outputType: $outputType,
 |    split: $splitABI
 |    buildType: $buildType,
 |    targetPlatform: $targetPlatformStr,
 |    mainPath: $mainPath
 --------------------------------------------------------------"

dartDefine=" --dart-define channel=$channel"
androidProjectArg=" --android-project-arg channel=$channel"
if [ "" == "$channel" ]; then
  dartDefine=""
  androidProjectArg=""
fi

echo "flutter build $outputType --$buildType$splitABI$targetPlatformStr$dartDefine$androidProjectArg -t $mainPath"
# shellcheck disable=SC2086
flutter build $outputType --$buildType $splitABI $targetPlatformStr $dartDefine $androidProjectArg -t $mainPath

outputDir="app/android/$buildType/"

mkdir -p "$outputDir"

echo ""
echo "😄 打包 $channel 的 $buildType 已完成 😄"

if [ "apk" == "$outputType" ]; then
  if [ 1 == "$split" ]; then
    if [ "$targetPlatform" -ge 1 ]; then
      mv "./build/app/outputs/flutter-apk/app-armeabi-v7a-$buildType.apk" "./$outputDir$outputName-$channel-32v${version}-$(date "+%Y%m%d%H%M").apk"
    fi
    if [ "$targetPlatform" -ge 2 -o "$targetPlatform" == 0 ]; then
      mv "./build/app/outputs/flutter-apk/app-arm64-v8a-$buildType.apk" "./$outputDir$outputName-$channel-64v${version}-$(date "+%Y%m%d%H%M").apk"
    fi
    if [ "$targetPlatform" -ge 3 ]; then
      mv "./build/app/outputs/flutter-apk/app-x86_64-$buildType.apk" "./$outputDir$outputName-$channel-x86v${version}-$(date "+%Y%m%d%H%M").apk"
    fi
  else
    mv "./build/app/outputs/flutter-apk/app-$buildType.apk" "./$outputDir$outputName-$channel-v${version}-$(date "+%Y%m%d%H%M").apk"
  fi
elif [ "appbundle" == "$outputType" ]; then
  mv "./build/app/outputs/bundle/$buildType/app-$buildType.aab" "./$outputDir$outputName-$channel-v${version}-$(date "+%Y%m%d%H%M").aab"
fi

echo ""
echo "========== 💪 Android打包完成 💪 =========="
echo ""
