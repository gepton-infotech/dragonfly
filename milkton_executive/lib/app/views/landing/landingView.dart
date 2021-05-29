import 'package:flutter/material.dart';
import 'package:milkton_executive/app/views/home/homeView.dart';
import 'package:milkton_executive/app/views/login/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingView extends StatefulWidget {
  @override
  _LandingViewState createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  bool _isLoggedIn;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: checkLogin(),
      builder: (context, response) {
        if (_isLoggedIn == null) {
          return LoginView();
        } else {
          if (_isLoggedIn) {
            return HomeView();
          } else {
            return LoginView();
          }
        }
      },
    );
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isLoggedIn = prefs.getBool('isLoggedIn');
    });
  }
}
