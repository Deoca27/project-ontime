import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';

import '../controllers/signup_controller.dart';

// class SignupView extends GetView<SignupController> {
//   const SignupView({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('SignupView'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'SignupView is working',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }

// Suggested code may be subject to a license. Learn more: ~LicenseLog:753703154.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:2712474974.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:4042714363.
class SignupView extends GetView<SignupController> {
  // const SignupView({Key? key}) : super(key: key);
    final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SizedBox(
            //   height: 80,
            // ),

            // Image.network(
            //   "https://thumbs.dreamstime.com/b/sign-up-member-icon-elegant-cyan-blue-round-button-sign-up-member-icon-isolated-elegant-cyan-blue-round-button-abstract-99714643.jpg",
            //   height: 100,
            // ),
            // SizedBox(
            //   height: 10,
            // ),

            // TextField(
            //   decoration: const InputDecoration(labelText: 'User Name'),
            //   // controller: Get.find<SignupController>().nameController,
            // ),
            // const SizedBox(height: 20),
            TextField(
              // decoration: const InputDecoration(labelText: 'Email'),
              // controller: Get.find<SignupController>().emailController,

              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Email",
              ),
            ),
            const SizedBox(height: 20),
            TextField(
            //   obscureText: true,
            //   decoration: const InputDecoration(labelText: 'Password'),
              // controller: Get.find<SignupController>().passwordController,

              controller: controller.cPassword,
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Password",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                cAuth.signup(
                  controller.cEmail.text,
                  controller.cPassword.text,
                );
              },
              child: const Text('Daftar'),
            ),
            SizedBox(
            height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Sudah Punya Akun ?"),
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
