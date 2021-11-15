import 'package:flutter/material.dart';
import 'package:flutter_advanced_course/presentation/color_manager.dart';
import 'package:flutter_advanced_course/presentation/values_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // main colors of the app
    primaryColor: ColorManager.primary,
    primaryColorLight: ColorManager.primaryOpacity70,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    accentColor: ColorManager.grey,

    // card view theme
    cardTheme: CardTheme(
      color: ColorManager.white,
      shadowColor: ColorManager.grey,
      elevation: AppSize.s4,
    ),

    // app bar theme

    // button theme

    // text theme

    //input decoration theme (text form field)
  );
}
