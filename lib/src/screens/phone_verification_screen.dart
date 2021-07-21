import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/authbloc/auth_bloc.dart';
import 'package:realcallerapp/src/screens/blank_page.dart';
import 'package:realcallerapp/src/screens/home.dart';
import 'package:realcallerapp/src/screens/profile_screens/add_user_info.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class PhoneVerificationScreen extends StatefulWidget {
  final AuthBloc authBloc;
  final String phoneNumber;

  const PhoneVerificationScreen(
      {Key? key, required this.authBloc, this.phoneNumber = ""})
      : super(key: key);
  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  late bool _isFormActive;
  late bool _isFormSubmitLoading;
  late TextEditingController _verificationCodeEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isFormActive = false;
    _isFormSubmitLoading = false;
    _verificationCodeEditingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          // title: Text(
          //   "Sign Up",
          //   style: TextStyle(color: Color(0xff0d0d0d)),
          // ),
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Color(0xff0d0d0d),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color(0xfffafafa),
          elevation: 0,
        ),
        body: MultiBlocProvider(
          providers: [BlocProvider.value(value: widget.authBloc)],
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is LoginFormSubmissionSuccess) {
                print("success2");
              } else if (state is VerificationFormActive) {
                setState(() {
                  _isFormActive = true;
                });
              } else if (state is VerificationFormDisabled) {
                setState(() {
                  _isFormActive = false;
                });
              } else if (state is LoginSuccess) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return Home();
                }));
              } else if (state is LoginSuccessWithoutUser) {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (BuildContext context) {
                  return AddUserInfo();
                }));
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
                          "Verify Your Phone Number",
                          style: TextStyle(
                              fontSize: 24,
                              color: CustomColors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          (state is VerificationCodeSentLoading)
                              ? "Sending verification code..."
                              : "We have sent code to " +
                                  widget.phoneNumber +
                                  ". Enter the code below.",
                          style: TextStyle(
                              fontSize: 14, color: CustomColors.greyDark),
                        ),
                        SizedBox(
                          height: 42,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          height: 50,
                          decoration: BoxDecoration(
                              color: Color(0xfff1f1f1),
                              borderRadius: BorderRadius.circular(10)),
                          child: TextField(
                            controller: _verificationCodeEditingController,
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            onChanged: (value) {
                              print("testing");
                              widget.authBloc
                                  .add(VerificationCodeChanged(code: value));
                            },
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Verification Code"),
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
                                print("clicked");
                                widget.authBloc.add(VerificationCodeSubmitEvent(
                                    code: _verificationCodeEditingController
                                        .text));
                              }
                            },
                            child: (_isFormSubmitLoading == true)
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                    backgroundColor: Colors.white,
                                  )
                                : Text(
                                    "Verify Now",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  )),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                widget.authBloc
                                  ..add(ResendCodeVerification(
                                      phoneNumber: widget.phoneNumber));
                              },
                              child: Text("Resend Code",
                                  style: TextStyle(
                                      fontFamily: "GilroyLight",
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
