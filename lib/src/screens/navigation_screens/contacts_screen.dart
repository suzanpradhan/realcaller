import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/contactbloc/contactbloc_bloc.dart';
import 'package:realcallerapp/models/message.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/repositories/contacts_repository.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';
import 'package:realcallerapp/src/screens/user_profile_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:realcallerapp/utils/constants/profiles_images.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
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
    return buildMultiBlocProvider();
  }

  MultiBlocProvider buildMultiBlocProvider() {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  ContactblocBloc()..add(RequestAllContactsEvent()))
        ],
        child: BlocConsumer<ContactblocBloc, ContactblocState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ContactsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Theme.of(context).appBarTheme.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Icon(
                                Icons.menu,
                                size: 20,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search",
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .textTheme
                                        .caption!
                                        .color),
                              ),
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                            ),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Icon(
                                Icons.more_vert,
                                size: 20,
                                color: Theme.of(context).iconTheme.color,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.contacts.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Contact _contact = state.contacts.elementAt(index);
                          ImageProvider _contactImage =
                              (_contact.avatar != null &&
                                      _contact.avatar!.isNotEmpty &&
                                      _contact.avatar.toString() != "[]")
                                  ? MemoryImage(
                                      state.contacts.elementAt(index).avatar!)
                                  : AssetImage(ProfileImages().getRandomImage())
                                      as ImageProvider;
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (BuildContext context) =>
                                        UserProfileScreen(
                                          contact: _contact,
                                          imageProvider: _contactImage,
                                        )));
                              },
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                                    state.contacts
                                                        .elementAt(index)
                                                        .displayName!,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color,
                                                        fontSize: 16,
                                                        fontFamily:
                                                            "GilroyLight"),
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
                                              _callNumber(_contact.phones!
                                                  .elementAt(0)
                                                  .value!);
                                            }),
                                        SizedBox(
                                          width: 18,
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                CupertinoPageRoute(builder:
                                                    (BuildContext context) {
                                              return MessageRoomScreen(
                                                  smsListing: SmsListing(
                                                      name:
                                                          _contact.displayName!,
                                                      userProfileImage:
                                                          _contactImage));
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
                        }),
                  )
                ],
              );
            } else if (state is NoContacts) {
              return Center(
                child: Container(
                  child: Text("No Contacts Found."),
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
        ));
  }
}
