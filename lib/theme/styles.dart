import 'package:flutter/material.dart';
import 'colors.dart';

class AppStyles {
  AppStyles._();

  static const Roboto = "Roboto";
  static const RobotoSlab ="RobotoSlab";

  static const boxShadow = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(6), topRight: Radius.circular(6)),
      boxShadow: [BoxShadow(blurRadius: 6, offset: Offset(0, 3), color: Color.fromRGBO(0, 0, 0, .16))]
  );

  static const textTheme = TextTheme(
      bodyText1: TextStyle(fontFamily: Roboto, fontSize: 14, color: AppColors.textDark),
      bodyText2: TextStyle(fontFamily: Roboto, fontSize: 12, color: AppColors.textDark),
      subtitle1: TextStyle(fontFamily: Roboto, fontSize: 14, color: AppColors.textDark),
      subtitle2: TextStyle(fontFamily: Roboto, fontSize: 12, color: AppColors.textDark),
      caption: TextStyle(fontFamily: Roboto, fontSize: 10, color: AppColors.lightGrey),
      headline6: TextStyle(fontFamily: Roboto, fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textDark),
      headline5: TextStyle(fontFamily: Roboto, fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textDark),
      headline4: TextStyle(fontFamily: Roboto, fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.textDark),
      headline3: TextStyle(fontFamily: Roboto, fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.textDark),
      headline2: TextStyle(fontFamily: Roboto, fontSize: 30, fontWeight: FontWeight.w900, color: AppColors.textDark)
  );
}
