import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/appThemeChanger/appthemechanger_bloc.dart';
import 'package:realcallerapp/blocs/settingsBloc/settingsmodel_bloc.dart';
import 'package:realcallerapp/models/settings.dart';
import 'package:realcallerapp/src/screens/settings_screens/about_us_screen.dart';
import 'package:realcallerapp/src/screens/settings_screens/appearance_settings_screen.dart';
import 'package:realcallerapp/src/screens/settings_screens/earning_screen.dart';
import 'package:realcallerapp/src/screens/settings_screens/general_settings_screen.dart';
import 'package:realcallerapp/src/screens/settings_screens/privacy_policy_screen.dart';
import 'package:realcallerapp/src/screens/settings_screens/spam_settings_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  List<Function> settingsFunction = [
    (context, SettingsmodelBloc bloc) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => EarningScreen()));
    },
    (context, SettingsmodelBloc bloc) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => GeneralSettingsScreen(
                settingsmodelBloc: bloc,
              )));
    },
    (context, SettingsmodelBloc bloc) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => SpamSettingsScreen(
                settingsmodelBloc: bloc,
              )));
    },
    (context, AppthemechangerBloc bloc) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => AppearanceSettingsScreen(
                appthemechangerBloc: bloc,
              )));
    },
    () {},
    (context, SettingsmodelBloc bloc) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => PrivacyPolicy()));
    },
    (BuildContext context, SettingsmodelBloc bloc) {
      Navigator.of(context).push(CupertinoPageRoute(
          builder: (BuildContext context) => AboutUsScreen()));
    },
    () {}
  ];
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              SettingsmodelBloc()..add(RequestSettingsDetails()),
        ),
      ],
      child: Column(
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Text(
              "Settings",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0d0d0d)),
            ),
          ),
          BlocConsumer<SettingsmodelBloc, SettingsmodelState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return Expanded(
                  child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      itemCount: settingData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: InkWell(
                            onTap: () {
                              if (state is SettingsDetailSuccess) {
                                settingsFunction[index](
                                    context,
                                    (index == 3)
                                        ? BlocProvider.of<AppthemechangerBloc>(
                                            context)
                                        : BlocProvider.of<SettingsmodelBloc>(
                                            context));
                              }
                            },
                            child: Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        settingData[index].settingIcon,
                                        size: 24,
                                        color: Theme.of(context)
                                            .bottomNavigationBarTheme
                                            .selectedItemColor,
                                      ),
                                      SizedBox(
                                        width: 14,
                                      ),
                                      Text(
                                        settingData[index].settingTitle,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "GilroyLight",
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .color),
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
                          ),
                        );
                      }));
            },
          )
        ],
      ),
    );
  }
}
