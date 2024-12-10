import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  // const ResetPasswordView({super.key});
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                labelText: "Enter Email",
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                cAuth.resetPassword(
                  controller.cEmail.text,
                );
              },
              child: const Text('Reset Password'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 34, 57, 150),
                foregroundColor: Colors.white,
              ),
            ),

          

            // SizedBox(
            // height: 10,
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text("Sudah Ingat Passwormu ?"),
            //     TextButton(
            //       onPressed: () {
            //         Get.back();
            //       },
            //       child: Text("Back"),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),

      // body: const Center(
      //   child: Text(
      //     'ResetPasswordView is working',
      //     style: TextStyle(fontSize: 20),
      //   ),
      // ),


    );
  }
}
