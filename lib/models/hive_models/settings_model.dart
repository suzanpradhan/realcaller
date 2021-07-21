import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 0)
class SettingsModel {
  @HiveField(0)
  bool isBackUpEnabled;
  @HiveField(1)
  bool isShowProfile;
  @HiveField(2)
  bool isShareLocation;
  @HiveField(3)
  bool isSpamProtection;

  SettingsModel(
      {required this.isBackUpEnabled,
      required this.isShareLocation,
      required this.isShowProfile,
      required this.isSpamProtection});
}
