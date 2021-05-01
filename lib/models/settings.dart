import 'package:flutter/material.dart';

class Settings {
  String settingTitle;
  IconData settingIcon;

  Settings({required this.settingTitle, required this.settingIcon});
}

List<Settings> settingData = <Settings>[
  Settings(settingTitle: "General", settingIcon: (Icons.settings)),
  Settings(settingIcon: (Icons.shield), settingTitle: "BlockList"),
  Settings(settingIcon: (Icons.ac_unit), settingTitle: "Appearance"),
  Settings(settingIcon: (Icons.ac_unit), settingTitle: "Caller Id"),
  Settings(settingIcon: (Icons.lock), settingTitle: "Privacy Policy"),
  Settings(settingIcon: (Icons.info), settingTitle: "About"),
  Settings(settingIcon: (Icons.logout), settingTitle: "LogOut")
];
