import 'package:flutter/material.dart';
import 'package:realcallerapp/src/screens/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        "https://images-ext-1.discordapp.net/external/BMKP2-N6re9a_FqF896d-3PDEtw3hdnFDte93PEWEm8/%3Fixid%3DMXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%253D%26ixlib%3Drb-1.2.1%26auto%3Dformat%26fit%3Dcrop%26w%3D333%26q%3D80/https/images.unsplash.com/photo-1552452518-f921c926b76b?width=288&height=433"))),
          ),
          SafeArea(
              child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Container(
                          child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To \nRealCaller!",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 38,
                            fontWeight: FontWeight.w900),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Lorem ipsum et dolore magna alqua.",
                        style:
                            TextStyle(color: Color(0xfffafafa), fontSize: 16),
                      )
                    ],
                  ))),
                  SizedBox(
                    height: 32,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return LoginScreen();
                      }));
                    },
                    color: Colors.white,
                    height: 50,
                    child: Text(
                      "Get Started",
                      style: TextStyle(fontSize: 18),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "By continuing, you agree to Terms and Conditions of RealCaller.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
