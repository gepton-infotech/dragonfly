import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:milkton_executive/app/milkton_app.dart';
import 'package:milkton_executive/constants/color_constant.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        systemNavigationBarColor: kWhite, statusBarColor: kPrimaryColor),
  );
  runApp(MilktonApp());
}
