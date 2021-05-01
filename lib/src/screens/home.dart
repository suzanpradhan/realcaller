import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:realcallerapp/src/screens/navigation_screens/contacts_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/home_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/location_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/message_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/settings_screen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late List<Widget> _navigationScreens;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _navigationScreens = <Widget>[
      HomeScreen(),
      MessageScreen(),
      LocationScreen(),
      ContactsScreen(),
      SettingsScreen()
    ];
    this._currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(
                      "https://wallpaperaccess.com/full/2213424.jpg",
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Alex Brooker",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "+973 439 2343 434",
                    style: TextStyle(
                        fontSize: 14,
                        color: Color(0xff707070),
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "Upgrade To Premium",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.remove_red_eye_outlined),
              title: Text("Who viewed my profile"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text("Notification"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text("Invite Friend"),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "Dark mode",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              trailing: CupertinoSwitch(
                  activeColor: Color(0xff0d0d0d),
                  value: true,
                  onChanged: (value) {}),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                "FAQ",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        items: [
          Icon(Icons.home),
          Icon(Icons.message),
          Icon(Icons.location_pin),
          Icon(Icons.people),
          Icon(Icons.settings)
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: SafeArea(
        child: _navigationScreens[_currentIndex],
        bottom: false,
      ),
    );
  }
}
