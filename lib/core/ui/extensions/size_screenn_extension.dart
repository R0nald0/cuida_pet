import 'dart:core';

import 'package:flutter_screenutil/flutter_screenutil.dart';

extension SizeScreennExtension on num{
  num get w => ScreenUtil().setWidth(this);
  num get h =>  ScreenUtil().setHeight(this);
  num get r =>  ScreenUtil().radius(this);
  num get sp =>  ScreenUtil().setSp(this);
  num get sw =>  ScreenUtil().screenWidth * this;
  num get sh =>  ScreenUtil().screenHeight * this;
  num get statusBar=>  ScreenUtil().statusBarHeight * this;
}