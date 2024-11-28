import 'package:flutter/material.dart';
import 'package:myapp/app/modules/sccreen/home_screen.dart';
import 'package:myapp/app/modules/sccreen/kehadiran.dart';
import 'package:myapp/app/modules/sccreen/profil.dart';
// import 'package:project_ontime/screen/kehadiran.dart';
// import 'package:project_ontime/screen/profil.dart';
// import 'package:project_ontime/screen/home_screen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  int _selectedIndex = 0;
  String _title = '';

  List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    Kehadiran(),
    Profil(),
  ];
  @override
  void initState() {
    super.initState();
    _title = 'default';
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          elevation: 2,
          toolbarHeight: 60,
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          centerTitle: true,
          title: _title == 'default' ? Container(
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
                                // Text(
                                //   'Hai, ',
                                //   overflow: TextOverflow.ellipsis,
                                //   maxLines: 1,
                                //   style: TextStyle(
                                //     fontSize: 20,
                                //     fontWeight: FontWeight.bold,
                                //     color: Asset.colorPrimary,
                                //   ),
                                // ),
                                Text(
                                  'Anya Melfissa',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Text(
                              'S1 - Teknik Komputer',
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 12,
                                // fontWeight: FontWeight.bold,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        // backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage:
                              AssetImage('assets/images/test.jpg'),
                              // NetworkImage('url'),
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ],
            ),
          )
          :Text(_title,
          maxLines: 1,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        preferredSize: Size.fromHeight(70.0),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Color.fromARGB(120, 0, 0, 0),
          selectedItemColor: Color.fromARGB(255, 0, 0, 0),
          items: [
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
            // BottomNavigationBarItem(
            //   label: "navbar 3",
            //   icon: Icon(Icons.calendar_today),
            // ),
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
          {
            _title = 'default';
          }
          break;
        case 1:
          {
            _title = 'default';
          }
          break;
        case 2:
          {
            // _title = 'navbar 2';
            _title = 'default';
          }
          break;
        // case 3:
        //   {
        //     _title = 'navbar 3';
        //   }
        //   break;
      }
    });
  }
}
