import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/settingsBloc/settingsmodel_bloc.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class SpamSettingsScreen extends StatefulWidget {
  final SettingsmodelBloc settingsmodelBloc;
  const SpamSettingsScreen({Key? key, required this.settingsmodelBloc})
      : super(key: key);

  @override
  _SpamSettingsScreenState createState() => _SpamSettingsScreenState();
}

class _SpamSettingsScreenState extends State<SpamSettingsScreen> {
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
            "Spam Settings",
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ),
        body: BlocConsumer<SettingsmodelBloc, SettingsmodelState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
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
                                "Spam Protection",
                                style: TextStyle(
                                    fontFamily: "GilroyLight",
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .color,
                                    fontWeight: FontWeight.bold),
                              )),
                              CupertinoSwitch(
                                  activeColor: CustomColors.purpleLightFaded,
                                  value: true,
                                  onChanged: (value) {
                                    if (state is SettingsDetailSuccess) {
                                      setState(() {
                                        state.settingsModel.isSpamProtection =
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
                                      "Reported Spam List",
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
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
