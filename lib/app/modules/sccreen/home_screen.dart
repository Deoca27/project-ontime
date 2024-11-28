import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
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
                  'Senin, 28 Oktober 2024',
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
            Container(
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
                    child: ElevatedButton(
                      onPressed: () => showAlertDialog(context),
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
