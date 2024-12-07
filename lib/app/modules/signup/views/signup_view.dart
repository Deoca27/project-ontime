import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/signup/controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.cPassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.cUsername,
              decoration: InputDecoration(
                labelText: "Username",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.cProdi,
              decoration: InputDecoration(
                labelText: "Prodi",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                cAuth.signup(
                  controller.cEmail.text,
                  controller.cPassword.text,
                  username: controller.cUsername.text,
                  prodi: controller.cProdi.text,
                );
              },
              child: const Text('Daftar'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah Punya Akun?"),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Login"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
