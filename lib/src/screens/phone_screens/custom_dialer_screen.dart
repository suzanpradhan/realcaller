import 'package:flutter/material.dart';
import 'package:flutter_dialpad/flutter_dialpad.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class CustomDialerScreen extends StatefulWidget {
  @override
  _CustomDialerScreenState createState() => _CustomDialerScreenState();
}

class _CustomDialerScreenState extends State<CustomDialerScreen> {
  @override
  Widget build(BuildContext context) {
    _callNumber(String number) async {
      bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
    }

    return Scaffold(
      backgroundColor: CustomColors.black,
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
            color: CustomColors.greyLight,
          ),
        ),
        centerTitle: true,
        backgroundColor: CustomColors.black,
        elevation: 0,
      ),
      body: SafeArea(
          child: DialPad(
              enableDtmf: false,
              outputMask: "(000) 000-0000",
              backspaceButtonIconColor: Colors.red,
              makeCall: (number) {
                print(number);
                _callNumber(number);
              })),
    );
  }
}
