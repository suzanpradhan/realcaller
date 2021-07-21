import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class Settings {
  String settingTitle;
  IconData settingIcon;

  Settings({required this.settingTitle, required this.settingIcon});
}

List<Settings> settingData = <Settings>[
  Settings(settingTitle: "Earn RealCoins", settingIcon: Icons.monetization_on),
  Settings(settingTitle: "General", settingIcon: (EvaIcons.settings2)),
  Settings(settingIcon: (EvaIcons.shield), settingTitle: "Spam"),
  Settings(settingIcon: (EvaIcons.eye), settingTitle: "Appearance"),
  Settings(settingIcon: (EvaIcons.phone), settingTitle: "Caller Id"),
  Settings(settingIcon: (EvaIcons.lock), settingTitle: "Privacy Policy"),
  Settings(settingIcon: (EvaIcons.info), settingTitle: "About"),
  Settings(settingIcon: (EvaIcons.logOut), settingTitle: "LogOut")
];
