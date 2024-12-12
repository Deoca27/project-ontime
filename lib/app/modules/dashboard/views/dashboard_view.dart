import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp/app/modules/screens/home_screen.dart';
import 'package:myapp/app/modules/screens/kehadiran.dart';
import 'package:myapp/app/modules/screens/profil.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  String _title = '';
  String username = '';
  String prodi = '';

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Kehadiran(),
    Profil(),
  ];

  @override
  void initState() {
    super.initState();
    _title = 'default';
    _fetchUserData(); // Panggil fungsi untuk mengambil data pengguna
  }

  Future<void> _fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        String uid = currentUser.uid;

        // Ambil data dari Firestore
        DocumentSnapshot userDoc =
            await FirebaseFirestore.instance.collection('users').doc(uid).get();

        if (userDoc.exists) {
          setState(() {
            username = userDoc.get('username') ?? 'Nama tidak ditemukan';
            prodi = userDoc.get('prodi') ?? 'Prodi tidak ditemukan';
          });
        } else {
          print("User document tidak ditemukan.");
        }
      }
    } catch (e) {
      print("Error mengambil data pengguna: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          elevation: 2,
          toolbarHeight: 60,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          title: _title == 'default'
              ? Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text(
                                  username,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              prodi,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        radius: 30,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage: AssetImage('assets/images/test.jpg'),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                )
              : Text(
                  _title,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
        ),
        preferredSize: const Size.fromHeight(70.0),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: const Color.fromARGB(120, 0, 0, 0),
          selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          items: const [
            BottomNavigationBarItem(
              label: "Beranda",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Kehadiran",
              icon: Icon(Icons.calendar_today),
            ),
            BottomNavigationBarItem(
              label: "Akun Saya",
              icon: Icon(Icons.person),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
        case 1:
        case 2:
          _title = 'default';
          break;
      }
    });
  }
}
