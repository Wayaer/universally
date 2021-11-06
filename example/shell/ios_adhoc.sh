#!/usr/bin/env bash

env=release
#ios配置证书文件
exportOptions=ExportOptionsAdHoc.plist

app="app/ios"
version=$(grep "version:" pubspec.yaml)
version=${version#version: }

mkdir -p "$app/$env/"
echo "ios===$env===$version===AdHoc"

echo "开始flutter build"
flutter build ios --analyze-size -t lib/main.dart --release

cd build/ios/iphoneos/Runner.app/Frameworks/App.framework
xcrun bitcode_strip -r app -o app

cd ../Flutter.framework
xcrun bitcode_strip -r Flutter -o Flutter

cd ../../../../../../ios

mkdir -p $env

echo "开始xcode build"

xcodebuild -workspace Runner.xcworkspace -scheme Runner -sdk iphoneos -configuration Release archive -archivePath $env/Runner.xcarchive

xcodebuild -exportArchive -archivePath $env/Runner.xcarchive -exportOptionsPlist $exportOptions -exportPath $env/runner -allowProvisioningUpdates

mv $env/runner/"common".ipa ../$app/$env/"common-Adhoc-v$version".$(date "+%Y%m%d%H%M").ipa

rm -rf "$env"

echo "iOS打包完成😄"
