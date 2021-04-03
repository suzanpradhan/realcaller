import 'dart:async';

import 'package:flutter/material.dart';
import 'package:realcallerapp/src/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
        () => {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => WelcomeScreen()))
            });
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Real Caller Splash Screen"),
        ),
      ),
    );
  }
}
