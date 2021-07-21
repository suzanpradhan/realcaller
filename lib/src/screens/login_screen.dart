import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/authbloc/auth_bloc.dart';
import 'package:realcallerapp/src/screens/home.dart';
import 'package:realcallerapp/src/screens/login_from_email.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'phone_verification_screen.dart';
import 'profile_screens/add_user_info.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _phoneController;
  late bool _isFormActive;
  late bool _isFormSubmitLoading;
  late CountryCode _selectedCountryCode;
  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _isFormActive = false;
    _isFormSubmitLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => AuthBloc()..add(LoadLoginFormEvent()),
              ),
            ],
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is LoginFormLoading) {
                  setState(() {
                    _isFormActive = false;
                  });
                } else if (state is LoginFormActive) {
                  setState(() {
                    _isFormActive = true;
                  });
                } else if (state is LoginFormDisabled) {
                  setState(() {
                    _isFormActive = false;
                  });
                } else if (state is LoginFormSubmissionSuccess) {
                  print("success1");
                  setState(() {
                    _isFormSubmitLoading = false;
                  });
                  Navigator.push(context,
                      MaterialPageRoute(builder: (newcontext) {
                    AuthBloc authBloc = BlocProvider.of<AuthBloc>(context);
                    return PhoneVerificationScreen(
                      authBloc: authBloc,
                      phoneNumber: state.phoneNumber,
                    );
                  }));
                } else if (state is LoginFormSubmissionLoading) {
                  setState(() {
                    _isFormSubmitLoading = true;
                  });
                } else if (state is LoginSuccess) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Home();
                  }));
                } else if (state is LoginSuccessWithoutUser) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return AddUserInfo();
                  }));
                }
              },
              builder: (context, state) {
                return SafeArea(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 60,
                          ),
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
                            "Login",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w900),
                          ),
                          Text(
                            "You've been missed.",
                            style: TextStyle(
                                color: Color(0xffa1a1a1), fontSize: 18),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 14),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xfff1f1f1),
                                borderRadius: BorderRadius.circular(10)),
                            child: CountryCodePicker(
                              initialSelection: 'IT',
                              favorite: ['+39', 'FR'],
                              // optional. Shows only country name and flag
                              showCountryOnly: false,
                              // optional. Shows only country name and flag when popup is closed.
                              showOnlyCountryWhenClosed: true,
                              // optional. aligns the flag and the Text left
                              alignLeft: false,
                              onInit: (code) {
                                _selectedCountryCode = code!;
                              },
                              onChanged: (code) {
                                setState(() {
                                  _selectedCountryCode = code;
                                });
                              },
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
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                BlocProvider.of<AuthBloc>(context)
                                  ..add(PhoneNumberChanged(phoneNumber: value));
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Phone"),
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              padding: EdgeInsets.all(6),
                              color: (_isFormActive == true)
                                  ? CustomColors.accentPurpleDark
                                  : CustomColors.grey,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                              onPressed: () {
                                if (_isFormActive == true &&
                                    _isFormSubmitLoading == false) {
                                  BlocProvider.of<AuthBloc>(context).add(
                                      LoginFromPhoneSubmitEvent(
                                          countryCode: _selectedCountryCode,
                                          phoneNumber: _phoneController.text));
                                }
                              },
                              child: (_isFormSubmitLoading == true)
                                  ? CircularProgressIndicator(
                                      strokeWidth: 2,
                                      backgroundColor: Colors.white,
                                    )
                                  : Text(
                                      "Continue",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  color: CustomColors.greyLight,
                                  height: 2,
                                ),
                              ),
                              Text(
                                "or",
                                style: TextStyle(
                                    fontFamily: "GilroyLight",
                                    fontSize: 16,
                                    color: CustomColors.grey),
                              ),
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  color: CustomColors.greyLight,
                                  height: 2,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          MaterialButton(
                              minWidth: double.infinity,
                              height: 50,
                              padding: EdgeInsets.all(6),
                              color: CustomColors.purpleLight,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              elevation: 0,
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginFromEmail()));
                              },
                              child: Text(
                                "Login with Email",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )),
                          // SizedBox(
                          //   height: 18,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         InkWell(
                          //           onTap: () {
                          //             Navigator.of(context).push(MaterialPageRoute(
                          //                 builder: (BuildContext context) {
                          //               return RegisterScreen();
                          //             }));
                          //           },
                          //           child: RichText(
                          //               text: TextSpan(
                          //                   style: TextStyle(fontSize: 16),
                          //                   children: <TextSpan>[
                          //                 TextSpan(
                          //                     text: "Don't have an account? ",
                          //                     style: TextStyle(color: Color(0xffa1a1a1))),
                          //                 TextSpan(
                          //                     text: "Sign Up",
                          //                     style: TextStyle(color: Color(0xff0d0d0d)))
                          //               ])),
                          //         ),
                          //         SizedBox(
                          //           height: 18,
                          //         ),
                          //         Text(
                          //           "OR",
                          //           style:
                          //               TextStyle(fontSize: 16, color: Color(0xffa1a1a1)),
                          //         ),
                          //       ],
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 18,
                          // ),
                          // MaterialButton(
                          //     minWidth: double.infinity,
                          //     height: 50,
                          //     padding: EdgeInsets.all(6),
                          //     color: Colors.blue,
                          //     shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(8)),
                          //     elevation: 0,
                          //     onPressed: () {},
                          //     child: Text(
                          //       "Connect with Google",
                          //       style: TextStyle(fontSize: 18, color: Colors.white),
                          //     )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )));
  }
}
