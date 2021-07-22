import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/spamUserBloc/spamuser_bloc.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/models/spam_model.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';
import 'package:realcallerapp/src/screens/user_profile_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:realcallerapp/utils/constants/profiles_images.dart';

class SpamCallLog extends StatefulWidget {
  @override
  _SpamCallLogState createState() => _SpamCallLogState();
}

class _SpamCallLogState extends State<SpamCallLog> {
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
    return BlocProvider(
      create: (context) => SpamuserBloc()..add(RequestAllSpams()),
      child: BlocConsumer<SpamuserBloc, SpamuserState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is AllUserSpamLoadSuccess) {
            return ListView.builder(
                itemCount: state.listOfContacts.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  SpamModel _contact = state.listOfContacts.elementAt(index);
                  ImageProvider _contactImage =
                      AssetImage(ProfileImages().getRandomImage());
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                child: Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        showTestDialog(
                                            userProfile: _contactImage);
                                      },
                                      child: CircleAvatar(
                                        radius: 28,
                                        backgroundImage: _contactImage,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            state.listOfContacts
                                                    .elementAt(index)
                                                    .firstName +
                                                " " +
                                                state.listOfContacts
                                                    .elementAt(index)
                                                    .lastname,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .color,
                                                fontSize: 16,
                                                fontFamily: "GilroyLight"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.phone,
                                      color: CustomColors.purpleLight,
                                    ),
                                    onPressed: () {
                                      // _callNumber(_contact.phoneNumber);
                                    }),
                                SizedBox(
                                  width: 18,
                                ),
                                IconButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        CupertinoPageRoute(
                                            builder: (BuildContext context) {
                                      return MessageRoomScreen(
                                          smsListing: SmsListing(
                                              name: _contact.firstName +
                                                  " " +
                                                  _contact.lastname,
                                              userProfileImage: _contactImage));
                                    }));
                                  },
                                  icon: Icon(
                                    Icons.message,
                                    color: CustomColors.purpleDarkFaded,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (state is AllUserSpamLoadFailed) {
            return Center(
              child: Container(
                child: Text(state.message),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: CustomColors.purpleLight,
              strokeWidth: 1,
            ));
          }
        },
      ),
    );
    ;
  }
}
