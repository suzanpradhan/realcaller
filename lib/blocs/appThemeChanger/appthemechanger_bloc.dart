import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:realcallerapp/utils/constants/app_theme_enums.dart';

part 'appthemechanger_event.dart';
part 'appthemechanger_state.dart';

class AppthemechangerBloc
    extends Bloc<AppthemechangerEvent, AppthemechangerState> {
  AppthemechangerBloc() : super(AppthemechangerInitial());

  @override
  Stream<AppthemechangerState> mapEventToState(
    AppthemechangerEvent event,
  ) async* {
    if (event is CheckCurrentAppTheme) {
      yield* checkCurrentAppTheme();
    } else if (event is ChangeAppTheme) {
      yield* changeAppTheme(appThemeEnum: event.appThemeEnum);
    }
  }

  Stream<AppthemechangerState> checkCurrentAppTheme() async* {
    var isDarkModeBox = await Hive.openBox('isDarkModeBox');
    print("Checking is Dark Mode.");
    if (isDarkModeBox.containsKey("isDarkMode")) {
      var isDarkModeValue = isDarkModeBox.get("isDarkMode");
      if (isDarkModeValue == 1) {
        print("checked: 1");
        yield AppThemeLoaded(isDarkMode: true);
      } else {
        print("checked: 2");
        yield AppThemeLoaded(isDarkMode: false);
      }
    } else {
      print("checked: 2");
      yield AppThemeLoaded(isDarkMode: false);
    }
  }

  Stream<AppthemechangerState> changeAppTheme(
      {required AppThemeEnum appThemeEnum}) async* {
    var isDarkModeBox = await Hive.openBox('isDarkModeBox');
    switch (appThemeEnum) {
      case AppThemeEnum.Light:
        print("0");
        isDarkModeBox.put("isDarkMode", 0);
        yield AppThemeLoaded(isDarkMode: false);
        break;
      case AppThemeEnum.Dark:
        print("1");
        isDarkModeBox.put("isDarkMode", 1);
        yield AppThemeLoaded(isDarkMode: true);
        break;
      default:
        isDarkModeBox.put("isDarkMode", 0);
        yield AppThemeLoaded(isDarkMode: false);
        break;
    }
  }
}
