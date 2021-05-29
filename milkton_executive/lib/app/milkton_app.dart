import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkton_executive/app/views/splash/splashView.dart';
import 'package:milkton_executive/configs/routes.dart';
import 'package:milkton_executive/configs/theme.dart';

class MilktonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Milkton App',
      home: SplashScreen(),
      theme: appTheme(),
      getPages: namedRoues,
    );
  }
}
