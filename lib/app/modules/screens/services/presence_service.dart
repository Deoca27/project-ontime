import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/alert_dialog.dart';

class PresenceService {
  static Future<void> handlePresence(BuildContext context, FirebaseFirestore firestore, FirebaseAuth auth) async {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        final DocumentReference userDoc = firestore.collection('users').doc(user.uid);
        final DocumentSnapshot snapshot = await userDoc.get();

        if (snapshot.exists) {
          final data = snapshot.data() as Map<String, dynamic>;
          if (data['presensi'] == false) {
            await userDoc.update({
              'presensi': true,
              'hadir': (data['hadir'] ?? 0) + 1,
            });
            CustomAlertDialog.showAlertDialog(context);
          }
        }
      }
    } catch (e) {
      print('Error updating presence: $e');
    }
  }
}