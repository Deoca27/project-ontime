import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  var isPasswordHidden = true.obs;

  final cEmail = TextEditingController();
  final cPassword = TextEditingController();

  @override
  void onClose() {
    cEmail.dispose();
    cPassword.dispose();
    super.onClose();
  }
}
