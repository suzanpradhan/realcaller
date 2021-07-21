import 'package:contacts_service/contacts_service.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/call_history_bloc/call_history_bloc_bloc.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/repositories/call_log_repo.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class UserProfileScreen extends StatefulWidget {
  final ImageProvider imageProvider;
  final Contact contact;
  UserProfileScreen({required this.imageProvider, required this.contact});
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  _callNumber(String number) async {
    bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: widget.imageProvider,
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                widget.contact.displayName!,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              color: Theme.of(context).appBarTheme.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      _callNumber(widget.contact.phones!.first.value!);
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.phone,
                          size: 20,
                          color: CustomColors.purpleLight,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Call",
                          style: TextStyle(color: CustomColors.purpleLight),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                          CupertinoPageRoute(builder: (BuildContext context) {
                        return MessageRoomScreen(
                            smsListing: SmsListing(
                                name: widget.contact.displayName!,
                                userProfileImage: widget.imageProvider));
                      }));
                    },
                    child: Column(
                      children: [
                        Icon(Icons.message,
                            size: 20, color: CustomColors.purpleLight),
                        SizedBox(
                          height: 8,
                        ),
                        Text("Message",
                            style: TextStyle(color: CustomColors.purpleLight))
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(Icons.block,
                          size: 20, color: CustomColors.purpleLight),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Block",
                          style: TextStyle(color: CustomColors.purpleLight))
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),

            // Phone Numbers
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text("Phones",
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  color: Theme.of(context).appBarTheme.backgroundColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.contact.phones!.first.value.toString(),
                          style: TextStyle(
                            fontSize: 16,
                            color: Theme.of(context).textTheme.bodyText1!.color,
                          )),
                    ],
                  ),
                ),
                // SizedBox(
                //   height: 8,
                // ),
                // Container(
                //   width: double.infinity,
                //   color: Color(0xfff1f1f1),
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 20,
                //     vertical: 10,
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text("9832432948",
                //           style: TextStyle(
                //             fontSize: 16,
                //             color: Color(0xff0d0d0d),
                //           )),
                //       Text("Mobile Provider1",
                //           style: TextStyle(
                //             fontSize: 14,
                //             color: Color(0xff707070),
                //           )),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Call History",
                    style: TextStyle(
                        color: Theme.of(context).textTheme.bodyText1!.color,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                BlocProvider(
                  create: (BuildContext context) => CallHistoryBlocBloc()
                    ..add(RequestAllCallLogOfSpecificPhone(
                        phone: widget.contact.phones!.first.value!)),
                  child:
                      BlocConsumer<CallHistoryBlocBloc, CallHistoryBlocState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      if (state is AllCallLogLoadedOfPhone) {
                        return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: state.allCallLogs.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) {
                              String elapsedTime = DateTimeFormat.relative(
                                  DateTime.fromMillisecondsSinceEpoch(
                                      state.allCallLogs[index].timestamp!),
                                  formatAfter: Duration(days: 1),
                                  format: 'M j, H:i a');
                              String callTime = DateTimeFormat.relative(
                                  DateTime.now().subtract(Duration(
                                      seconds:
                                          state.allCallLogs[index].duration!)),
                                  abbr: true);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            elapsedTime,
                                            style: TextStyle(
                                                fontFamily: "GilroyLight",
                                                fontSize: 20,
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                state
                                                    .allCallLogs[index].number!,
                                                style: TextStyle(
                                                    fontFamily: "GilroyLight",
                                                    fontSize: 14,
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .caption!
                                                        .color),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              CallLogRepo.getCallTypeIcon(
                                                  callType: state
                                                      .allCallLogs[index]
                                                      .callType!)
                                            ],
                                          )
                                        ],
                                      ),
                                      Text(
                                        callTime,
                                        style: TextStyle(
                                            fontFamily: "GilroyLight",
                                            fontSize: 16),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else if (state is NoCallLogsOfPhone) {
                        return Center(
                          child: Text(
                            state.message,
                            style: TextStyle(
                                fontFamily: "GilroyLight",
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                          ),
                        );
                      } else {
                        return CircularProgressIndicator(
                          strokeWidth: 1,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        );
                      }
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 20),
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.symmetric(
                //       horizontal: 20,
                //       vertical: 10,
                //     ),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(10),
                //       color: Theme.of(context).appBarTheme.backgroundColor,
                //     ),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Column(
                //           crossAxisAlignment: CrossAxisAlignment.start,
                //           children: [
                //             Text("12:28 PM",
                //                 style: TextStyle(
                //                   fontSize: 16,
                //                   color: Theme.of(context)
                //                       .textTheme
                //                       .bodyText1!
                //                       .color,
                //                 )),
                //             Text("9832432948",
                //                 style: TextStyle(
                //                   fontSize: 14,
                //                   color: CustomColors.greyDark,
                //                 )),
                //           ],
                //         ),
                //         Icon(
                //           Icons.phone,
                //           size: 20,
                //           color: CustomColors.purpleLight,
                //         )
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 8,
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
