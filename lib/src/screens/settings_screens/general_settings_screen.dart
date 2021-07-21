import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/settingsBloc/settingsmodel_bloc.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class GeneralSettingsScreen extends StatefulWidget {
  final SettingsmodelBloc settingsmodelBloc;
  const GeneralSettingsScreen({Key? key, required this.settingsmodelBloc})
      : super(key: key);

  @override
  _GeneralSettingsScreenState createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  late bool isBackUpSwitchEnable;
  late bool isShowProfileEnable;
  late bool isShareLocationEnable;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isBackUpSwitchEnable = false;
    isShowProfileEnable = false;
    isShareLocationEnable = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.settingsmodelBloc..add(RequestSettingsDetails()),
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
            "General Settings",
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ),
        body: BlocConsumer<SettingsmodelBloc, SettingsmodelState>(
          listener: (context, state) {
            if (state is SettingsDetailSuccess) {
              setState(() {
                isBackUpSwitchEnable = state.settingsModel.isBackUpEnabled;
                isShareLocationEnable = state.settingsModel.isShareLocation;
                isShowProfileEnable = state.settingsModel.isShowProfile;
              });
            } else if (state is UpdateSettingsLoading) {
              setState(() {});
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    color: Theme.of(context).bottomAppBarColor,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Update Profile",
                                      style: TextStyle(
                                          fontFamily: "GilroyLight",
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Color(0xffbfbfbf),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Backup",
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
                                      activeColor:
                                          CustomColors.purpleLightFaded,
                                      value: isBackUpSwitchEnable,
                                      onChanged: (value) {
                                        if (state is SettingsDetailSuccess) {
                                          setState(() {
                                            state.settingsModel
                                                .isBackUpEnabled = value;
                                            BlocProvider.of<SettingsmodelBloc>(
                                                    context)
                                                .add(UpdateSettingDetails(
                                                    settingsModel:
                                                        state.settingsModel));
                                          });
                                        }
                                      })
                                ],
                              ),
                              SizedBox(
                                height: 14,
                              ),
                              Text(
                                "Back up your call history, contacts, messages, media and block list.",
                                style: TextStyle(
                                    fontFamily: "GilroyLight",
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color,
                                    fontSize: 14),
                              )
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Show My Profile in Discover People.",
                                      style: TextStyle(
                                          fontFamily: "GilroyLight",
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  CupertinoSwitch(
                                      activeColor:
                                          CustomColors.purpleLightFaded,
                                      value: isShowProfileEnable,
                                      onChanged: (value) {
                                        if (state is SettingsDetailSuccess) {
                                          setState(() {
                                            state.settingsModel.isShowProfile =
                                                value;
                                            BlocProvider.of<SettingsmodelBloc>(
                                                    context)
                                                .add(UpdateSettingDetails(
                                                    settingsModel:
                                                        state.settingsModel));
                                          });
                                        }
                                      })
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      "Share My Location",
                                      style: TextStyle(
                                          fontFamily: "GilroyLight",
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  CupertinoSwitch(
                                      activeColor:
                                          CustomColors.purpleLightFaded,
                                      value: isShareLocationEnable,
                                      onChanged: (value) {
                                        if (state is SettingsDetailSuccess) {
                                          setState(() {
                                            state.settingsModel
                                                .isShareLocation = value;
                                            BlocProvider.of<SettingsmodelBloc>(
                                                    context)
                                                .add(UpdateSettingDetails(
                                                    settingsModel:
                                                        state.settingsModel));
                                          });
                                        }
                                      })
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    color: Theme.of(context).bottomAppBarColor,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Deactivate Account",
                                  style: TextStyle(
                                      fontFamily: "GilroyLight",
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .color,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
