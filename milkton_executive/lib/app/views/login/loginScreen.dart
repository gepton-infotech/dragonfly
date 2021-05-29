import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkton_executive/app/views/home/homeScreen.dart';
import 'package:milkton_executive/constants/color_constant.dart';
import 'package:milkton_executive/services/login.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String phone = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Scaffold(
            body: SafeArea(
          child: Center(
            child: Container(
              width: size.width * 0.90,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    child: Image.asset('assets/images/dicon.png'),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter phone number',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDarkBlue),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDarkBlue),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12.0),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDarkBlue),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kDarkBlue),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                    ),
                  ),
                  Container(
                    width: size.width * 0.90,
                    height: size.height * 0.06,
                    child: ElevatedButton(
                      onPressed: () async {
                        var data = await checkCredentials(phone, password);
                        if (data != null) {
                          print(data);
                          if (data['status'] == 'Authenticated') {
                            Get.offAll(HomeView());
                          } else if (data['status'] == 'Wrong Password') {
                            Get.snackbar('Wrong Password:',
                                'The password which you entered is invalid',
                                backgroundColor: kDarkBlue, colorText: kWhite);
                          } else if (data['status'] ==
                              "No such executive exist") {
                            Get.snackbar("Wrong Phone",
                                "No user exist with this phone number",
                                backgroundColor: kDarkBlue, colorText: kWhite);
                          }
                        } else {
                          Get.snackbar('Something went wrong',
                              'Please contact the admin',
                              backgroundColor: kDarkBlue, colorText: kWhite);
                        }
                      },
                      child: Text(
                        'LOGIN',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
