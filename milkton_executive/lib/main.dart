import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/app/milkton_app.dart';
import 'package:milkton_executive/constants/color_constant.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        systemNavigationBarColor: kWhite, statusBarColor: kPrimaryColor),
  );
  await initHiveForFlutter();
  runApp(MilktonApp());
}
