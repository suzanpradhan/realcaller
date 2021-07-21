import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/appThemeChanger/appthemechanger_bloc.dart';
import 'package:realcallerapp/utils/constants/app_theme_enums.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class AppearanceSettingsScreen extends StatefulWidget {
  final AppthemechangerBloc appthemechangerBloc;
  const AppearanceSettingsScreen({Key? key, required this.appthemechangerBloc})
      : super(key: key);

  @override
  _AppearanceSettingsScreenState createState() =>
      _AppearanceSettingsScreenState();
}

class _AppearanceSettingsScreenState extends State<AppearanceSettingsScreen> {
  late bool isDarkModeEnable;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDarkModeEnable = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.appthemechangerBloc..add(CheckCurrentAppTheme()),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: IconTheme.of(context).color,
            ),
          ),
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          title: Text(
            "Appearance Settings",
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ),
        body: BlocConsumer<AppthemechangerBloc, AppthemechangerState>(
          listener: (context, state) {
            if (state is AppThemeLoaded) {
              setState(() {
                isDarkModeEnable = state.isDarkMode;
              });
            } else if (state is AppThemeChanged) {
              setState(() {
                isDarkModeEnable = state.isDarkMode;
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    children: [
                      Container(
                        color: Theme.of(context).bottomAppBarColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Dark Mode",
                              style: TextStyle(
                                  fontFamily: "GilroyLight",
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            CupertinoSwitch(
                                activeColor: CustomColors.purpleLightFaded,
                                value: isDarkModeEnable,
                                onChanged: (value) {
                                  if (state is AppThemeLoaded ||
                                      state is AppThemeChanged) {
                                    setState(() {
                                      if (value) {
                                        BlocProvider.of<AppthemechangerBloc>(
                                                context)
                                            .add(ChangeAppTheme(
                                                appThemeEnum:
                                                    AppThemeEnum.Dark));
                                      } else {
                                        BlocProvider.of<AppthemechangerBloc>(
                                                context)
                                            .add(ChangeAppTheme(
                                                appThemeEnum:
                                                    AppThemeEnum.Light));
                                      }
                                    });
                                  }
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ));
          },
        ),
      ),
    );
  }
}
