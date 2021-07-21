import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:realcallerapp/utils/extensions/string_extensions.dart';

class RealCallerDialer extends StatefulWidget {
  @override
  _RealCallerDialerState createState() => _RealCallerDialerState();
}

// const CHANNEL = "flutter_native_channel";
// const Call_Method = "makeCall";
// const platform = const MethodChannel(CHANNEL);

class _RealCallerDialerState extends State<RealCallerDialer> {
  TextEditingController _phoneController = TextEditingController();

  addNumberDigit(String digit) {
    setState(() {
      _phoneController.text = _phoneController.text + digit;
    });
  }

  _callNumber(String number) async {
    (await FlutterPhoneDirectCaller.callNumber(number))!;
    // String phoneNumber = number;
    // await platform.invokeMethod(Call_Method, {"phoneNumber": phoneNumber});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
            child: TextField(
              controller: _phoneController,
              enabled: false,
              keyboardType: TextInputType.phone,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
              ),
              style: TextStyle(
                  fontSize: 32,
                  fontFamily: "GilroyLight",
                  color: Theme.of(context).textTheme.bodyText1!.color),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addNumberDigit("1");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "1",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("2");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "2",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("3");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addNumberDigit("4");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "4",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("5");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "5",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("6");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "6",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addNumberDigit("7");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "7",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("8");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "8",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("9");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "9",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    addNumberDigit("*");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "*",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("0");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "0",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    addNumberDigit("#");
                  },
                  highlightColor: Colors.transparent,
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Theme.of(context).accentIconTheme.color),
                    child: Center(
                      child: Text(
                        "#",
                        style: TextStyle(
                            fontSize: 32,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(width: 60, height: 60, color: Colors.transparent),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: CustomColors.purpleLight),
                  child: Center(
                      child: IconButton(
                    icon: Icon(
                      EvaIcons.phone,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      _callNumber(_phoneController.text);
                    },
                  )),
                ),
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Theme.of(context).accentIconTheme.color),
                  child: Center(
                    child: IconButton(
                        icon: Icon(Icons.backspace),
                        onPressed: () {
                          setState(() {
                            _phoneController.text =
                                _phoneController.text.removeLast();
                            print(_phoneController.text);
                          });
                        }),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
