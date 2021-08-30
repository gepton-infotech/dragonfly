import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:milkton_executive/app/views/landing/landingView.dart';
import 'package:milkton_executive/services/remote_config.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    RemoteConfigService _remoteConfigService = RemoteConfigService();
    _remoteConfigService.setupRemoteConfig();
    Timer(Duration(seconds: 3), () => Get.off(LandingView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: Center(
        child: Lottie.asset(
          'assets/splash/splash.json',
          repeat: false,
          reverse: false,
          animate: true,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
