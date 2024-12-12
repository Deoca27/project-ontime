import 'package:flutter/material.dart';
import 'package:myapp/app/modules/screens/services/attendance_service.dart';
import 'package:myapp/app/modules/screens/components/attendance_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class Kehadiran extends StatefulWidget {
  const Kehadiran({super.key});

  @override
  State<Kehadiran> createState() => _KehadiranState();
}

class _KehadiranState extends State<Kehadiran> {
  final AttendanceService attendanceService = AttendanceService();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  int jumlahHadir = 0;
  int izinAbsen = 0;
  int izinSakit = 0;

  @override
  void initState() {
    super.initState();
    fetchAttendanceData();
  }

  Future<void> fetchAttendanceData() async {
    final data = await attendanceService.fetchAttendanceData();
    if (data != null) {
      setState(() {
        jumlahHadir = data['hadir'] ?? 0;
        izinAbsen = data['alpa'] ?? 0;
        izinSakit = data['izin'] ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Informasi Kehadiran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            AttendanceWidget(jumlahHadir: jumlahHadir, izinAbsen: izinAbsen, izinSakit: izinSakit),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            const Text(
              "Tanggal Kehadiran",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TableCalendar(
                firstDay: DateTime(2020),
                lastDay: DateTime(2100),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: (day) {
                  return []; // Tidak ada acara
                },
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
