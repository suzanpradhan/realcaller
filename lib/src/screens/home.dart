import 'package:cached_network_image/cached_network_image.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
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
              child: Text(
                'Side menu',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              decoration: BoxDecoration(
                  color: Colors.green,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: CachedNetworkImageProvider(
                          'https://wallpaperaccess.com/full/2213424.jpg'))),
            )
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
