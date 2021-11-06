#!/usr/bin/env bash

echo "清理 build"
flutter clean
rm -rf build

echo "开始获取 packages 插件资源"
flutter packages get

sh ./shell/android.sh
#sh ./shell/ios.sh
#sh ./shell/ios_adhoc.sh