/// 截取日期 2020-01-01
String subDate(DateTime dateTime) => dateTime.toString().substring(0, 10);

/// 截取日期 10:10:10
String subTime(DateTime dateTime) => dateTime.toString().substring(11, 19);

/// 判断url
bool isUrl(String code) => code.length > 4 && code.substring(0, 4) == 'http';
