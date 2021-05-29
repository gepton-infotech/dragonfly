import 'package:get/get.dart';
import 'package:milkton_executive/app/views/home/homeScreen.dart';
import 'package:milkton_executive/app/views/login/loginScreen.dart';

List<GetPage> namedRoues = [
  GetPage(name: '/', page: () => HomeView()),
  GetPage(name: '/login', page: () => LoginView()),
];
