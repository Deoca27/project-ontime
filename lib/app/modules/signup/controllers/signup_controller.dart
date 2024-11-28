import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController

  // final count = 0.obs;
  // @override
  // void onInit() {
  //   super.onInit();
  // }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  // void increment() => count.value++;

  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  @override
  void onClose() {
    cEmail.dispose();
    cPassword.dispose();
    super.onClose();
  }
}
