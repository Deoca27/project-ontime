import 'package:flutter/material.dart';
// import 'package:get/route_manager.dart';
import 'package:get/get.dart';
import 'package:myapp/app/controllers/auth_controller.dart';
import 'package:myapp/app/modules/login/views/login_view.dart';
// import 'package:project_ontime/event/event_pref.dart';
// import 'package:project_ontime/screen/login.dart';

class Profil extends StatefulWidget {
  // const Profil({super.key});
  final cAuth = Get.find<AuthController>();

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: const Text('Personal Information'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to personal information page
              },
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            ListTile(
              title: const Text('Change Password'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to change password page
              },
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            ListTile(
              title: const Text('Change Email'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to change email page
              },
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            ListTile(
              title: const Text('Documentation'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to documentation page
              },
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            ListTile(
              title: const Text('Contact'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Navigate to contact page
              },
            ),
            Divider(height: 1, color: Colors.grey.shade300),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black, width: 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () {
                    // Logout action
                    // Get.back();
                    widget.cAuth.logout();
                  },
                  child: const Text('Logout'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
