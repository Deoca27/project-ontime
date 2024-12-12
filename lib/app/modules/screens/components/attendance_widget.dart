import 'package:flutter/material.dart';

class AttendanceWidget extends StatelessWidget {
  final int jumlahHadir;
  final int izinAbsen;
  final int izinSakit;

  const AttendanceWidget({
    Key? key,
    required this.jumlahHadir,
    required this.izinAbsen,
    required this.izinSakit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            title: const Text('Semua mata kuliah'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // Navigasi ke semua mata kuliah
            },
          ),
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Jumlah hadir',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const Divider(),
              Text(
                '$jumlahHadir',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildInfoCard('Izin absen', izinAbsen),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _buildInfoCard('Izin sakit', izinSakit),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, int count) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          Text(
            '$count',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
