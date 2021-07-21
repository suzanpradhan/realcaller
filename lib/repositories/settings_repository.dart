import 'package:hive/hive.dart';
import 'package:realcallerapp/models/hive_models/settings_model.dart';

class SettingsRepo {
  Future<SettingsModel> getSettingsModel() async {
    try {
      var box = await Hive.openBox('settings');
      if (box.isNotEmpty) {
        return box.getAt(0) as SettingsModel;
      } else {
        SettingsModel settingsModel = SettingsModel(
            isBackUpEnabled: true,
            isShareLocation: false,
            isShowProfile: true,
            isSpamProtection: true);
        box.add(settingsModel);
        return settingsModel;
      }
    } catch (e) {
      return Future.error("Settigs Load Failed.");
    }
  }

  Future<SettingsModel> updateSettingsModel(
      {required SettingsModel settingsModel}) async {
    var box = await Hive.openBox('settings');
    try {
      box.putAt(0, settingsModel);
      return settingsModel;
    } catch (e) {
      return Future.error("Settings Update Failed.");
    }
  }
}
