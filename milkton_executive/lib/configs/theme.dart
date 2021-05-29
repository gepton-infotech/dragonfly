import 'package:flutter/material.dart';
import 'package:milkton_executive/constants/color_constant.dart';

ThemeData appTheme() {
  return ThemeData(
      primaryColor: kPrimaryColor,
      bottomAppBarColor: kWhite,
      primaryColorLight: kWhite,
      primaryColorDark: kTangyYellow,
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        primary: kDarkBlue,
      )));
}
