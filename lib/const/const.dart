import 'package:flutter/material.dart';
import 'package:flutter_waya/flutter_waya.dart';

class UConstant {
  UConstant._();

  /// 页面返回带 返回参数
  /// Page returns with return parameters
  static const String popBack = 'popBack';

  /// 页面返回刷新
  /// Page back refresh
  static const String refresh = 'refresh';

  /// 返回成功接口
  /// Return successful interface
  static const String successCode = '200';

  static const String privacy = 'isPrivacy';

  /// localApi
  static const String localApi = 'localApi';

  /// hasLogTs
  static const String hasLogTs = 'hasLogTs';

  /// defaultApi
  static const String defaultApi = 'defaultApi';

  /// isRelease
  static const String isRelease = 'isRelease';

  static const double longWidth = 333;
}

class UIS {
  UIS._();

  static const IconData settingApi = Icons.settings_applications;
  static const IconData playCircleFill = Icons.play_circle_outline;
  static const IconData pause = Icons.pause;
  static const IconData play = Icons.play_arrow_rounded;
  static const IconData playDisabled = Icons.play_disabled;
  static const IconData clear = Icons.clear;
  static const IconData add = Icons.add;
  static const IconData search = Icons.search;
  static const IconData back = Icons.arrow_back_ios_outlined;
  static const IconData androidBack = Icons.arrow_back;
}

class UAS {
  UAS._();

  static const String eyeClose = 'lib/res/svg/eye_close.svg';
  static const String eyeOpen = 'lib/res/svg/eye_open.svg';
  static const String noDataIcon = 'lib/res/svg/no_data.svg';
}

class UCS {
  UCS._();

  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;

  static const Color black = Colors.black;
  static const Color black70 = Color(0x70000000);
  static const Color black50 = Color(0x50000000);
  static const Color mainBlack = Color(0xFF333333);

  static const Color background = Color(0xFFF9F9F9);
  static const Color lineColor = Color(0x60E6E6E6);

  static const Color hintTextColor = Color(0xFFd7d7d7);
  static const Color grayTextColor = Color(0xFFC6CACE);
  static const Color titleTextColor = Color(0xFF666666);
  static const Color smallTextColor = Color(0x804D4D4D);
  static const Color defaultTextColor = Color(0xFF333333);
  static const Color largeTextColor = Color(0xFF292929);
}

class UStyle {
  UStyle._();

  /// 统一阴影样式
  /// Unified Shadow Style
  static List<BoxShadow> getBasicBoxShadow({Color? color}) => getBoxShadow(
      color: color ?? UCS.lineColor.withOpacity(0.4),
      offset: const Offset(0.0, 0.0), //阴影xy轴偏移量
      blurRadius: 3.0, //阴影模糊程度
      spreadRadius: 2.0 //阴影扩散程度
      );
}

bool isPad = deviceWidth > 500;

/// 下拉刷新
bool pullDown = false;

/// 上拉加载
bool pullUp = false;

/// 是否是内测版
bool isBeta = false;

/// beta 版本 是否显示log
bool hasLogTs = false;

///dev user
String devUserName = '';
String devPassword = '';
