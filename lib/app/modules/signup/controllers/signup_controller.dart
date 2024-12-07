import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final cEmail = TextEditingController();
  final cPassword = TextEditingController();
  final cUsername = TextEditingController();
  final cProdi = TextEditingController();

  @override
  void onClose() {
    cEmail.dispose();
    cPassword.dispose();
    cUsername.dispose();
    cProdi.dispose();
    super.onClose();
  }
}
