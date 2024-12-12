import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AttendanceService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<Map<String, dynamic>?> fetchAttendanceData() async {
    try {
      final User? user = auth.currentUser;
      if (user != null) {
        final DocumentSnapshot snapshot =
            await firestore.collection('users').doc(user.uid).get();

        if (snapshot.exists) {
          return snapshot.data() as Map<String, dynamic>;
        }
      }
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
    return null;
  }
}
