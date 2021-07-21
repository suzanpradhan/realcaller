import 'package:flutter/material.dart';
import 'package:logger_flutter/logger_flutter.dart';
import 'package:realcallerapp/src/screens/profile_screens/add_user_info.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'onboarding_screens/main_onboarding_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: LogConsoleOnShake(
          dark: true,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                  fit: BoxFit.cover,
                  image:
                      AssetImage("assets/images/welcome_screen_background.png"),
                )),
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
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logos/realcaller_text_logo.png"))),
                          ),
                          Text(
                            "Welcome To \nRealCaller!",
                            style: TextStyle(
                                fontFamily: "GilroyBold",
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.w900),
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          Text(
                            "Lorem ipsum et dolore magna alqua.",
                            style: TextStyle(
                                color: Color(0xfffafafa),
                                fontFamily: "GilroyLight",
                                fontSize: 16),
                          )
                        ],
                      ))),
                      SizedBox(
                        height: 32,
                      ),
                      MaterialButton(
                        minWidth: double.infinity,
                        splashColor: CustomColors.purpleLight,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return MainOnboardingScreen();
                          }));
                        },
                        color: Colors.white,
                        height: 50,
                        child: Text(
                          "Get Started",
                          style: TextStyle(
                              fontSize: 18,
                              color: CustomColors.black,
                              fontWeight: FontWeight.w600,
                              fontFamily: "GilroyLight"),
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
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: "GilroyLight"),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
