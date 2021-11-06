import 'package:flutter_waya/utils/src/screen_fit.dart';

export 'src/colors.dart';
export 'src/constant.dart';
export 'src/icons.dart';
export 'src/styles.dart';

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
