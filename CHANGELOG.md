## 8.0.1

* `BaseTextField`新增三个参数

## 8.0.0

* Update dependencies
* `extended_image_library`、`package_info_plus`、`connectivity_plus`、`device_info_plus`、`android_intent_plus`
* 修复 `connectivity_plus` 新版回调状态
* `TextExtraLarge`、`TextLarge`、`TextNormal`、`TextSmall`添加全部样式属性

## 7.1.6

* `BaseDioOptions` 添加 `enableCheckNetwork`,用于请求接口时是否校验网络状态
* `BaseDioOptions` 的 `showLoading` 修改为 `enableLoading`
* `BaseDioOptions` 的 `pullHideLoading` 修改为 `enablePullHideLoading`
* `BaseDioOptions` 新增 `hideCode`
* 修复 `BaseDio` 单独添加 `loading` 时无法关闭

## 7.1.3

* `UserPrivacyAlert`新增`textColor`和`highlightColor`
* `BaseDioOptions` 添加 `buildBaseModelState`,用于构建默认的 `BaseModel`
* 修改 `GifController` 为 `AnimationController`

## 7.1.0

* Change the `textColor` in `UConfig` to `textStyle`
* Remove `isMaybePop`, `enableLeading`, and `appBarAction` for `BaseScaffold`
* Remove `BackIcon`,use `BackButton`
* Remove `BaseAppBar`use `AppBar`

## 7.0.1

* `Global()` changed to `Universally()`
* `GlobalConfig()` changed to `UConfig()`
* `BHP()` changed to `BasePreferences()`

## 6.7.1

* Remove the `provider` package
* Add `TextFieldConfig` to support global configuration as `BaseTextField`

## 6.6.1

* Support web
* Fixed `enableLeading` misalignment of `BaseAppBar`

## 6.5.3

* Fixed the `headers` of `BaseDio` `options` being replaced
* Update dependencies

## 6.5.1

* `BaseScaffold` adds `body`
* Split `BaseApp` and add `BaseMaterialApp`, `BaseCupertinoApp`, `BaseWidgetsApp`.
* Migrate to 3.19.0
* Update dependencies

## 6.4.4

* Modify the `maxLines` and `minLines` of the `BaseTextField` and add the `TextEditingController`
  extension method

## 6.4.1

* Update dependencies
* example Supports windows

## 6.4.0

* Removed `DesktopWindowsSize`, and Added `WindowsSize`.
* Removed `Curiosity().desktop`, and Added `window_manager`.
* `Global().setConfig()` adds `windowOptions`
* The scripts directory adds macos and windows support

## 6.3.1

* Change `BasePackage` to `PackageInfoPlus`
* Change `BaseConnectivity` to `ConnectivityPlus`
* Change `BaseDeviceInfo` to `DeviceInfoPlus`

## 6.2.2

* Migrate to 3.16.0

## 6.1.0

* `FontType` removed, please use `FontWeights` or `FontWeight`
* Change `TextDefault` to `TextNormal`
* Change `TextVeryLarge` to `TextExtraLarge`

## 6.0.8

* Update dependencies
* Add `SpinKit()`

## 6.0.4

* fix problems

## 6.0.3

* Change all `Basic` to `Base`
* `GlobalConfig` is changed to `Global`
* Change `ProjectConfig` to `GlobalConfig`

## 5.2.2

* Modify the permission application method
* Modify the popup method invocation mode

## 5.1.1

* Update dependencies
* Migrate to Flutter 3.13.0

## 4.1.0

* Update dependencies
* Migrate to Flutter 3.10.0

## 3.5.5

* Remove the setSemanticsEnabled
* Update dependencies

## 3.5.3

* Remove the  `MainBasicScaffold`, Use the `isRootPage` of `BasicScaffold`
* Change `appBarLeft` to `appBarLeading`
* Change `appBarRight` to `appBarAction`
* Change `MainTabPageBuilder` to `TabPage`

## 3.5.2+2

* Change the `CustomDivider` to `BasicDivider`
* Modify the style of `AlertWithUserPrivacy`

## 3.5.2

* In `BasicAppBar`, change the `text` to `titleText` and change the `title` type to `Widget`, Change
  hasLeading to enableLeading
* In `BasicScaffold`, add `appBarTitleText` and change the `appBarTitle` type to `Widget`, Change
  hasLeading to enableLeading
* `UserPrivacyCheckbox` adds `fontSize`

## 3.5.1

* Updating dependencies

## 3.5.0+2

* Added the `BasicTabBar()`

## 3.5.0

* Updating dependencies

## 3.3.2+2

* Remove some svg

## 3.3.2

* Add channel support

## 3.3.1

* Updating dependencies

## 3.2.0+2

* Updating dependencies
* Fixed BasicList issues

## 3.1.0

* Change the `UrlCache` to `ApiCache`
* Change the `hasLogTs` to `isDebugger`
* Change the `Url` to `Api`
* Change the `UConstant` to `UConst`

## 3.0.0

* Updated dio to 5.0.0
* Fixed an issue with duplicate setting of contentType

## 2.2.0+1

* Handle the failure of `BasicModel` parsing

## 2.2.0

* Update `extended_image`

## 2.1.0

* `AppBarConfig` adds `titleColor`
* Change `expand` to `extension` in `BasicDioOptions` and `BasicModel`

## 2.0.1+1

* Compatible with Flutter 3.7.0

## 1.7.0

* Remove `showNetworkToast`, `alertNotNetwork`, `onConnectivityChanged` from `BasicApp()`,Please
  use `BasicConnectivity()`

## 1.6.2+2

* The `BasicImage` was redeveloped and the `BasicResizeImage` was added

## 1.6.1

* `BasicDioOptions` Adds more methods

## 1.6.0+1

* Update some plug-ins

## 1.5.0+1

* Remove appPath from `ProjectConfig()`,
* Add cachePath to `ProjectConfig()`,If you do not set cachePath, the default cache path is
  automatically used

## 1.3.3

* Change the original ExtendedFutureBuilder() to CustomFutureBuilder()
* Added new ExtendedFutureBuilder() extension for FutureBuilder()
* Added new ExtendedStreamBuilder() extension for StreamBuilder()

## 1.3.2+2

* Add `BasicTextField()`
* Modify `searchTextMode` to `searchTextPositioned`
* Modify `sendSMSMode` to `sendSMSPositioned`

## 1.3.1+1

* Add `RefreshControllers()`

## 1.3.0+3

* Add `ApiCache()`

## 1.3.0+2

* Use Hive as the persistent storage tool
* Replace SP() with BHP()

## 1.2.0

* Modify the incorrect naming

## 1.1.1

* Add `appBarConfig`、`textColor` for `ProjectConfig()`
* Add `Gif()`

## 1.1.0+1

* Update Flutter version 3.3.0
* Update Dart to 2.18.0

## 1.0.7

* Add `BasicCupertinoSwitch()`
* Dynamically set `Dio` return result parsing key

## 1.0.6

* Add `SwitchApiButton()`、`USpacing()`、`UButton()`、`PushSwitchState()`

## 1.0.3

* Change `globalKey` to `globalNavigatorKey`
* `BasicDioOptions` adds `extraData` and `extraParams`
* `header` in `BasicDioOptions` is changed to extraHeader

## 1.0.1

* Adapter flutter@3.0.0

## 0.9.1+3

* Add `showUserPrivacyAlert()`
* Remove `alertLoading()`,use `showLoading()`

## 0.9.0

* Optimize BasicDio()

## 0.8.7

* Update components to adapt to the new version

## 0.8.1

* Modify `BasicApp`

## 0.8.0

* Change all `Base` to `Basic`

## 0.7.3

* Remove `BaseApp()` non-required parameter

## 0.6.3

* Update version

## 0.0.6

* Add doc