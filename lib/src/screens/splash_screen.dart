import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/auth2bloc/auth2bloc_bloc.dart';
import 'package:realcallerapp/src/screens/home.dart';
import 'package:realcallerapp/src/screens/login_screen.dart';
import 'package:realcallerapp/src/screens/profile_screens/add_user_info.dart';
import 'package:realcallerapp/src/screens/welcome_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Timer(
    //     Duration(seconds: 2),
    //     () => {
    //           Navigator.of(context)
    //               .push(MaterialPageRoute(builder: (BuildContext context) {
    //             return WelcomeScreen();
    //           }))
    //         });
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => Auth2blocBloc()..add(CheckPermissionStatusEvent()))
      ],
      child: BlocConsumer<Auth2blocBloc, Auth2blocState>(
        listener: (context, state) {
          if (state is AllPermissionGrantedState) {
            print("All Permission Granted!");
            BlocProvider.of<Auth2blocBloc>(context)
              ..add(CheckUserLoginStatusEvent());
          } else if (state is NotAllPermissionGrantedState) {
            print("Not All Permission Granted!");
          } else if (state is UserHasLoggedInState) {
            print("User has Logged in");
            BlocProvider.of<Auth2blocBloc>(context)..add(CheckUserHasProfile());
          } else if (state is UserHasNotBeenLoggedInState) {
            print("User has not been logged in.");
            BlocProvider.of<Auth2blocBloc>(context)
              ..add(CheckUserIsFirstTimeEvent());
          } else if (state is UserIsNotFirstTimeState) {
            print("User is not first time.");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return LoginScreen();
            }));
          } else if (state is UserIsFirstTimeState) {
            print("User is first time.");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return WelcomeScreen();
            }));
          } else if (state is UserHasProfile) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return Home();
            }));
          } else if (state is UserHasNotProfile) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) {
              return AddUserInfo();
            }));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: CustomColors.accentPurpleDark,
            body: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/images/logos/realcaller_text_logo.png"))),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 1,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
