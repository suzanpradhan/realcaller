import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/discoverPeople/discoverpeople_bloc.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class DiscoverPeopleScreen extends StatefulWidget {
  const DiscoverPeopleScreen({Key? key}) : super(key: key);

  @override
  _DiscoverPeopleScreenState createState() => _DiscoverPeopleScreenState();
}

class _DiscoverPeopleScreenState extends State<DiscoverPeopleScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DiscoverpeopleBloc()..add(RequestDiscoverPeople()),
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
            "Discover People",
            style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
        ),
        body: BlocConsumer<DiscoverpeopleBloc, DiscoverpeopleState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is DiscoverPeopleLoaded) {
              return GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.75,
                  children: state.discoveredPeoples
                      .map((data) => DiscoverPeopleCard(user: data))
                      .toList());
            } else if (state is DiscoverPeopleLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: CustomColors.purpleDarkFaded,
                  strokeWidth: 1,
                ),
              );
            } else if (state is DiscoverPeopleLoadFailed) {
              return Center(
                child: Text(
                  state.message,
                  style: TextStyle(
                      fontFamily: "GilroyLight",
                      fontSize: 14,
                      color: Theme.of(context).textTheme.bodyText1!.color),
                ),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                  strokeWidth: 1,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class DiscoverPeopleCard extends StatefulWidget {
  final BasicUser user;
  const DiscoverPeopleCard({Key? key, required this.user}) : super(key: key);

  @override
  _DiscoverPeopleCardState createState() => _DiscoverPeopleCardState();
}

class _DiscoverPeopleCardState extends State<DiscoverPeopleCard> {
  _callNumber(String number) async {
    bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
  }

  showTestDialog({required BasicUser user}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Container(
              // height: 320,
              decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  (user.profileUrl == "")
                      ? CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/no_image.png"),
                          radius: 42,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(user.profileUrl),
                          radius: 42,
                        ),
                  ListTile(
                    title: Text(
                      "Name: " + user.firstname + " " + user.lastname,
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Email: " + user.email,
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Phone: " + user.phone,
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: CustomColors.purpleLight,
                          ),
                          onPressed: () {
                            _callNumber(user.phone);
                          }),
                      SizedBox(
                        width: 18,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (BuildContext context) {
                            return MessageRoomScreen(
                                smsListing: SmsListing(
                                    name: user.firstname + " " + user.lastname,
                                    userProfileImage: (user.profileUrl == "")
                                        ? AssetImage(
                                            "assets/images/no_image.png")
                                        : NetworkImage(user.profileUrl)
                                            as ImageProvider));
                          }));
                        },
                        icon: Icon(
                          Icons.message,
                          color: CustomColors.purpleDarkFaded,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showTestDialog(user: widget.user);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          decoration: BoxDecoration(color: Theme.of(context).cardColor),
          child: Column(
            children: [
              Container(
                height: 160,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: (widget.user.profileUrl != "")
                            ? NetworkImage(widget.user.profileUrl)
                            : AssetImage("assets/images/no_image.png")
                                as ImageProvider)),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration:
                          BoxDecoration(color: Theme.of(context).cardColor),
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        widget.user.firstname + " " + widget.user.lastname,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontFamily: "GilroyLight",
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
