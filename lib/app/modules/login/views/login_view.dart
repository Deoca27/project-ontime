import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final cAuth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.network(
              "https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEiG7QX8TlmfwYVWWuPOU5YOKDVv7sPS6IREk9S3ZUth7isqBW2crF5FBiFzfTFp9IRC_fQgv9_SnMbFmscGZYTCWozUM7CSSK00SJopovgPHm4nOPFlI7Hzdq9Yrw6_FB0R__pTJsFMfosnR-d24Pw0wh9n0IRT-pUALh9CuXJWFwJlZ8DouC3QxFYcuII/s985/Screenshot%202024-11-23%20151803.png",
              height: 50,
            ),
            ),

            SizedBox(height: 50),
            Text(
              'Sign In..',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(
              'Please enter your sign in information',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            
            SizedBox(height: 30),
            Text(
              'E-Mail Address',
              style: TextStyle(fontSize: 16, 
              // fontWeight: FontWeight.bold, 
              color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            TextField(
              controller: controller.cEmail,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelText: "Enter Email",
              ),
            ),

            SizedBox(height: 30),
            Text(
              'Password',
              style: TextStyle(fontSize: 16, 
              // fontWeight: FontWeight.bold,
              color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Obx(
              () => TextField(
                controller: controller.cPassword,
                obscureText: controller.isPasswordHidden.value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: "Enter Password",
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      controller.isPasswordHidden.toggle();
                    },
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Text("Forgot Password?"),
                onPressed: () {
                  Get.offAllNamed(Routes.RESET_PASSWORD);
                },
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                cAuth.login(
                  controller.cEmail.text,
                  controller.cPassword.text,
                );
              },
              child: Text("Sign In"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 34, 57, 150),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Sesuaikan angka untuk tingkat kotak
                ),
              ),
            ),
            SizedBox(height: 10),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Text("Belum Punya Akun ?"),
                TextButton(
                  onPressed: () {
                    Get.toNamed(Routes.SIGNUP);
                  },
                  child: Text("Register"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
