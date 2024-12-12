import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20,),
              // Gambar dari assets
              Image.asset(
                'assets/images/checkmark.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(height: 16),
              Text(
                'Absensi berhasil',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Anda berhasil mengisi kehadiran untuk mata kuliah ini.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Menutup dialog
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[900], // Warna biru untuk tombol
                  foregroundColor: Colors.white, // Warna putih untuk teks
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: Size(500, 50),
                ),
                child: const Text(
                  'Menu utama',
                  style: TextStyle(
                    fontWeight: FontWeight.bold, // Membuat teks bold
                    fontSize: 16, // Ukuran teks opsional
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> handlePresence(BuildContext context) async {
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
              // 'alpa': ((data['alpa'] ?? 0) - 1).clamp(0, double.infinity),
            });
            showAlertDialog(context);
          }
        }
      }
    } catch (e) {
      print('Error updating presence: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    String todayDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(DateTime.now());

    return Scaffold(
      body: SingleChildScrollView(  // Membungkus seluruh konten dengan SingleChildScrollView
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            // Tanggal
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
            // Kelas Saat Ini
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
                                  onPressed: () => handlePresence(context),
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
            // Jadwal Hari Ini
            const Text(
              'Jadwal hari ini',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // Membuat ListView yang dapat di-scroll
            ListView(
              shrinkWrap: true,  // Untuk membuat ListView hanya mengambil ruang yang dibutuhkan
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

class ScheduleCard extends StatelessWidget {
  final String title;
  final String time;

  const ScheduleCard({required this.title, required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
