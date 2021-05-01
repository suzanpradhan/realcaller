import 'package:flutter/material.dart';
import 'package:realcallerapp/models/settings.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xfffafafa),
          elevation: 0,
          title: Text(
            "Settings",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xff0d0d0d)),
          ),
        ),
        Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: settingData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                settingData[index].settingIcon,
                                size: 24,
                                color: Color(0xff00ca78),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Text(
                                settingData[index].settingTitle,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                            color: Color(0xffbfbfbf),
                          )
                        ],
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
