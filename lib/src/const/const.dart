import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:universally/universally.dart';

class UConst {
  UConst._();

  /// 消息推送
  static const String isPush = 'isPush';

  /// 页面返回带 返回参数
  /// Page returns with return parameters
  static const String popBack = 'popBack';

  /// 页面返回刷新
  /// Page back refresh
  static const String refresh = 'refresh';

  static const String isPrivacy = 'isPrivacy';

  /// localApi
  static const String localApi = 'localApi';

  /// isDebugger
  static const String isDebugger = 'isDebugger';

  /// defaultApi
  static const String defaultApi = 'defaultApi';

  /// isRelease
  static const String isRelease = 'isRelease';

  /// channel
  static const String channel = 'channel';

  /// release
  static const String release = 'release';

  /// beta
  static const String beta = 'beta';
}

class UIS {
  UIS._();

  static const IconData settingApi = Icons.settings;
  static const IconData playCircleFill = Icons.play_circle_outline;
  static const IconData pause = Icons.pause;
  static const IconData play = Icons.play_arrow_rounded;
  static const IconData playDisabled = Icons.play_disabled;
  static const IconData clear = Icons.clear;
  static const IconData add = Icons.add;
  static const IconData search = Icons.search;
  static const IconData back = Icons.arrow_back_ios_outlined;
  static const IconData androidBack = Icons.arrow_back;

  /// 空数据
  static const IconData empty = _IconData(0xe621);

  /// 眼睛关闭
  static const IconData eyeClose = _IconData(0xe65b);

  /// 眼睛打开
  static const IconData eyeOpen = _IconData(0xe659);
}

class _IconData extends IconData {
  const _IconData(super.codePoint)
      : super(fontFamily: 'Universally', fontPackage: 'universally');
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
}

class UStyle {
  UStyle._();

  /// 统一阴影样式
  /// Unified Shadow Style
  static List<BoxShadow> getBaseBoxShadow({Color? color}) => getBoxShadow(
        color: color ?? UCS.lineColor.withValues(alpha: 0.4),
        offset: const Offset(0.0, 0.0), //阴影xy轴偏移量
        blurRadius: 3.0, //阴影模糊程度
        spreadRadius: 2.0, //阴影扩散程度
      );

  static List<BoxShadow> getBoxShadow({
    int num = 1,
    Color color = Colors.black12,
    double? radius,
    BlurStyle blurStyle = BlurStyle.normal,
    double blurRadius = 0.05,
    double spreadRadius = 0.05,
    Offset? offset,
  }) =>
      num.generate(
        (index) => BoxShadow(
          color: color,
          blurStyle: blurStyle,
          blurRadius: radius ?? blurRadius,
          spreadRadius: radius ?? spreadRadius,
          offset: offset ?? const Offset(0, 0),
        ),
      );
}

/// 下拉刷新
bool pullDown = false;

/// 上拉加载
bool pullUp = false;

/// 是否是内测版
bool isBeta = false;

/// beta 版本 是否显示log
bool isDebugger = false;

/// 渠道版本
String currentChannel = defaultTargetPlatform.name.toLowerCase();

///dev user
String devUserName = '';
String devPassword = '';
