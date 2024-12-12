import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myapp/app/routes/app_pages.dart';

class AuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> get streamAuthStatus => auth.authStateChanges();

  // Fungsi untuk sign up
  void signup(String emailAddress, String password, {required String username, required String prodi}) async {
  try {
    // Membuat pengguna baru
    UserCredential myUser = await auth.createUserWithEmailAndPassword(
      email: emailAddress,
      password: password,
    );

    // Menyimpan data pengguna di Firestore
    await FirebaseFirestore.instance.collection('users').doc(myUser.user!.uid).set({
      'username': username,
      'prodi': prodi,
      'email': emailAddress,
      'hadir': 0, // Nilai awal hadir
      'alpa': 0, // Nilai awal alpa
      'izin': 0, // Nilai awal izin
      'presensi': false, 
    });

    // Mengirim email verifikasi
    await myUser.user!.sendEmailVerification();

    // Tampilkan dialog konfirmasi email
    Get.defaultDialog(
      title: "Verifikasi email",
      middleText: "Kami telah mengirimkan verifikasi ke email $emailAddress. Silakan periksa inbox Anda.",
      onConfirm: () {
        Get.back(); // Menutup dialog
        Get.back(); // Kembali ke halaman login
      },
      textConfirm: "OK",
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}


  // Fungsi untuk login
  void login(String email, String password) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user!.emailVerified) {
        // Mengambil data pengguna dari Firestore
        DocumentReference userDocRef = firestore.collection('users').doc(credential.user!.uid);
        DocumentSnapshot userDoc = await firestore
            .collection('users')
            .doc(credential.user!.uid)
            .get();

        if (userDoc.exists) {

          // Update field presensi menjadi false dan alpa +1
          await userDocRef.update({
          'presensi': false,
          // 'alpa': (userDoc['alpa'] ?? 0) + 1, // Tambahkan 1 ke field alpa
        });

          print("User data: ${userDoc.data()}");
          Get.offAllNamed(Routes.DASHBOARD); // navigasi ke dashboard
        } else {
          Get.defaultDialog(
            title: "Proses Gagal",
            middleText: "Data pengguna tidak ditemukan di Firestore.",
          );
        }
      } else {
        Get.defaultDialog(
          title: "Proses Gagal!",
          middleText: "Email belum diverifikasi.",
          textConfirm: "OK",
          onConfirm: () {
            Get.back();
          },
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: "No user found for that email.",
        );
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.defaultDialog(
          title: "Proses Gagal",
          middleText: "Wrong password provided for that user.",
        );
      } else {
        Get.defaultDialog(
          title: "Terjadi Kesalahan",
          middleText: "Error: ${e.message}",
        );
      }
    }
  }

  // Fungsi logout
  void logout() async {
    await auth.signOut();
    Get.offAllNamed(Routes.LOGIN);
  }

  // Fungsi reset password
  void resetPassword(String email) async {
    if (email != "" && GetUtils.isEmail(email)) {
      try {
        await auth.sendPasswordResetEmail(email: email);
        Get.defaultDialog(
          title: "Berhasil",
          middleText: "Kami telah mengirimkan reset password ke $email",
          onConfirm: () {
            Get.back();
            Get.back();
          },
          textConfirm: "OK",
        );
      } catch (e) {
        Get.defaultDialog(
          title: "Terjadi kesalahan",
          middleText: "Tidak dapat melakukan reset password.",
        );
      }
    } else {
      Get.defaultDialog(
        title: "Terjadi kesalahan",
        middleText: "Email tidak valid",
      );
    }
  }
}
