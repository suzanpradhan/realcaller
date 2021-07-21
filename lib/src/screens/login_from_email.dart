import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/src/screens/home.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:realcallerapp/blocs/email_sign_in_bloc/emailsignin_bloc.dart';

class LoginFromEmail extends StatefulWidget {
  @override
  _LoginFromEmailState createState() => _LoginFromEmailState();
}

class _LoginFromEmailState extends State<LoginFromEmail> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  bool isPasswordSeen = false;
  bool isEmailFormActive = false;
  bool isFormButtonLoading = false;

  checkIfEmailFormIsActive() {
    if (_emailTextController.text != "" &&
        _passwordTextController.text.length > 8) {
      setState(() {
        isEmailFormActive = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => EmailsigninBloc(),
          )
        ],
        child: BlocConsumer<EmailsigninBloc, EmailsigninState>(
          listener: (context, state) {
            if (state is EmailSignInSuccess) {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Home()));
            } else if (state is EmailSignInFailed) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                state.message,
                style: TextStyle(color: Colors.red, fontFamily: "GilroyLight"),
              )));
            } else if (state is EmailSignInLoading) {
              setState(() {
                isFormButtonLoading = true;
              });
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 40,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/logos/logo_realcaller_purple.png"))),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Text(
                        "Login with Email",
                        style: TextStyle(
                            fontSize: 32, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "Sign in with email and password.",
                        style:
                            TextStyle(color: Color(0xffa1a1a1), fontSize: 18),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfff1f1f1),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: _emailTextController,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {},
                          decoration: InputDecoration(
                              border: InputBorder.none, hintText: "Email"),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 14),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Color(0xfff1f1f1),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                onChanged: (value) {
                                  checkIfEmailFormIsActive();
                                },
                                keyboardType: TextInputType.text,
                                controller: _passwordTextController,
                                obscureText: !isPasswordSeen,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Password"),
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                                icon: Icon((isPasswordSeen)
                                    ? EvaIcons.eye
                                    : EvaIcons.eyeOff),
                                onPressed: () {
                                  setState(() {
                                    isPasswordSeen = !isPasswordSeen;
                                  });
                                })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MaterialButton(
                        minWidth: double.infinity,
                        height: 50,
                        padding: EdgeInsets.all(6),
                        color: (isEmailFormActive)
                            ? CustomColors.accentPurpleDark
                            : CustomColors.grey,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 0,
                        onPressed: () {
                          if (isEmailFormActive) {
                            // createMyProfile(context: context);
                            BlocProvider.of<EmailsigninBloc>(context).add(
                                EmailFormSubmitted(
                                    email: _emailTextController.text,
                                    password: _passwordTextController.text));
                          }
                        },
                        child: (state is EmailSignInLoading)
                            ? CircularProgressIndicator(
                                strokeWidth: 1,
                                backgroundColor: Colors.white,
                              )
                            : Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
