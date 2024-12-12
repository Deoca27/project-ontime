import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'components/schedule_card.dart';
import 'services/presence_service.dart';
import 'services/date_service.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String todayDate = DateService.getFormattedDate();

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Center(
              child: Container(
                alignment: Alignment.center,
                width: 500,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  todayDate,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Kelas saat ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            StreamBuilder<DocumentSnapshot>(
              stream: firestore.collection('users').doc(auth.currentUser?.uid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Text('Terjadi kesalahan.');
                }

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  final bool presensi = data['presensi'] ?? false;

                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blue[900],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Dasar Komputer Pemrograman - MK021',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Dr. Imam Drajat, S.Kom., Ph.D.',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '13:00 WIB - 14:00 WIB',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 8),
                        Align(
                          alignment: Alignment.center,
                          child: presensi
                              ? Text(
                                  'Anda sudah melakukan presensi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : ElevatedButton(
                                  onPressed: () => PresenceService.handlePresence(context, firestore, auth),
                                  child: const Text('Hadir'),
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    minimumSize: Size(500, 50),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
                }

                return Text('Data tidak ditemukan.');
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Jadwal hari ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ListView(
              shrinkWrap: true,
              children: const [
                ScheduleCard(
                  title: 'Bahasa Indonesia - MK003',
                  time: '15:00 WIB - 16:00 WIB',
                ),
                ScheduleCard(
                  title: 'Teknologi Informasi - MK011',
                  time: '16:00 WIB - 17:00 WIB',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}