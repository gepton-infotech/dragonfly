import 'package:get/state_manager.dart';

class PhoneController extends GetxController {
  int phone = 1;
  void increment() {
    phone++;
    update();
  }
}
