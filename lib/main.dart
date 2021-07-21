// @dart=2.9
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:logger_flutter/logger_flutter.dart';
import 'package:realcallerapp/blocs/appThemeChanger/appthemechanger_bloc.dart';
import 'package:realcallerapp/models/hive_models/settings_model.dart';
import 'package:realcallerapp/src/screens/splash_screen.dart';
import 'package:realcallerapp/utils/app_theme.dart';
import 'package:realcallerapp/utils/constants/locales.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  const CHANNEL = "flutter_native_channel";
  // const Call_Method = "makeCall";
  const platform = const MethodChannel(CHANNEL);
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(SettingsModelAdapter());
  await Firebase.initializeApp();

  runApp(MyApp());
  log();
}

var logger = Logger(
  printer: PrettyPrinter(),
  output: ExampleLogOutput(),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
  output: ExampleLogOutput(),
);

class ExampleLogOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);
    LogConsole.add(event);
  }
}

void log() {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AppthemechangerBloc()..add(CheckCurrentAppTheme()),
        ),
      ],
      child: BlocConsumer<AppthemechangerBloc, AppthemechangerState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AppThemeLoaded) {
            return MaterialApp(
              title: 'Flutter Demo',
              supportedLocales: Locales.supportedLocales,
              localizationsDelegates: Locales.localizationsDelegate,
              darkTheme: AppTheme.darkTheme,
              theme: AppTheme.lightTheme,
              themeMode: state.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: SplashScreen(),
            );
          } else {
            return MaterialApp(
                title: 'Flutter Demo',
                supportedLocales: Locales.supportedLocales,
                localizationsDelegates: Locales.localizationsDelegate,
                darkTheme: AppTheme.darkTheme,
                theme: AppTheme.lightTheme,
                themeMode: ThemeMode.light,
                home: SplashScreen());
          }
        },
      ),
    );
  }
}
