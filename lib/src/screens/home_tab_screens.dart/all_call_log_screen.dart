import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/calllogbloc/calllogbloc_bloc.dart';
import 'package:realcallerapp/models/call_log.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:realcallerapp/utils/constants/profiles_images.dart';
import 'package:realcallerapp/utils/extensions/string_extensions.dart';
import 'package:realcallerapp/src/screens/phone_screens/call_history_screen.dart';

class AllCallLogScreen extends StatefulWidget {
  @override
  _AllCallLogScreenState createState() => _AllCallLogScreenState();
}

class _AllCallLogScreenState extends State<AllCallLogScreen> {
  _callNumber(String number) async {
    bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
  }

  showTestDialog({ImageProvider? userProfile, String text = ""}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Container(
              height: 320,
              decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  borderRadius: BorderRadius.circular(14)),
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: userProfile != null
                              ? userProfile
                              : AssetImage(ProfileImages().getRandomImage()))),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider.value(
              value: BlocProvider.of<CalllogblocBloc>(context)
                ..add(RequestAllCallLogEvent()))
        ],
        child: BlocConsumer<CalllogblocBloc, CalllogblocState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AllCallLogLoaded) {
                return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        itemCount: state.allCallLogs.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return FutureBuilder<CallLogUIModel>(
                              future: state.allCallLogs[index],
                              builder: (BuildContext context,
                                  AsyncSnapshot<CallLogUIModel> snapshot) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: InkWell(
                                    onTap: () {
                                      // navigatorCallback(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  BlocProvider.value(
                                                    value: BlocProvider.of<
                                                            CalllogblocBloc>(
                                                        context),
                                                    child: CallHistoryScreen(
                                                      phone:
                                                          snapshot.data!.phone,
                                                    ),
                                                  )));
                                      // });
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  showTestDialog(
                                                      userProfile: snapshot.data
                                                          ?.userProfileImage);
                                                },
                                                child: CircleAvatar(
                                                  radius: 28,
                                                  backgroundImage: snapshot
                                                      .data?.userProfileImage,
                                                  // child: Text(
                                                  //     (snapshot.data != null)
                                                  //         ? snapshot
                                                  //             .data!.displayName
                                                  //             .getInitials()
                                                  //         : "",
                                                  //     style: TextStyle(
                                                  //         color: Colors.black,
                                                  //         fontFamily:
                                                  //             "GilroyLight")),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 14,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // CONTACT NAME
                                                  Text(
                                                    (snapshot.data != null)
                                                        ? snapshot
                                                            .data!.displayName
                                                        : "",
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color,
                                                        fontFamily:
                                                            "GilroyLight"),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(
                                                    children: [
                                                      (snapshot.data
                                                                  ?.callTypeIcon ==
                                                              null)
                                                          ? Container()
                                                          : snapshot.data
                                                                  ?.callTypeIcon
                                                              as Widget,
                                                      Text(
                                                        ("${snapshot.data?.callType.toString().split(".").last.capitalize()}"),
                                                        style: TextStyle(
                                                            color: CustomColors
                                                                .greyDark,
                                                            fontFamily:
                                                                "GilroyLight"),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          IconButton(
                                              icon: Icon(
                                                Icons.phone,
                                                size: 24,
                                                color: Color(0xffa1a1a1),
                                              ),
                                              onPressed: () {
                                                _callNumber(
                                                    snapshot.data!.phone);
                                              })
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        }));
              } else if (state is NoCallLogs) {
                return Center(child: Text(state.message));
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }

  // void navigatorCallback(Function callback) {
  //   WidgetsBinding.instance!.addPostFrameCallback((_) {
  //     callback();
  //   });
  // }
}
