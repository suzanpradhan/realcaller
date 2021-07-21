import 'package:flutter/material.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/repositories/sms_repo.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return buildColumn(context);
  }

  Column buildColumn(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).appBarTheme.backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Icon(
                      Icons.menu,
                      size: 20,
                      color: IconTheme.of(context).color,
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
                            color: Theme.of(context).textTheme.caption!.color)),
                    style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyText1!.color),
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
            child: FutureBuilder(
                future: SmsRepo().getAllMessages(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<SmsListing>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return MessageRoomScreen(
                                  smsListing: snapshot.data![index],
                                );
                              })),
                              child: Container(
                                width: double.infinity,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 28,
                                            backgroundImage: snapshot
                                                .data![index].userProfileImage,
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
                                                  snapshot.data![index].name!,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText1!
                                                          .color,
                                                      fontFamily: "GilroyLight",
                                                      fontSize: 16),
                                                ),
                                                SizedBox(
                                                  height: 8,
                                                ),
                                                Text(
                                                  snapshot.data![index]
                                                      .recentMessage!,
                                                  style: TextStyle(
                                                      fontFamily: "GilroyLight",
                                                      fontSize: 14,
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .caption!
                                                          .color),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Text(
                                      snapshot.data![index].recentMessageTime!,
                                      style: TextStyle(
                                          fontFamily: "GilroyLight",
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .color,
                                          fontSize: 14),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else {
                    return Center(
                      child: Container(
                        child: Text(
                          "No Messages.",
                          style: TextStyle(
                              fontFamily: "GilroyLight",
                              fontSize: 16,
                              color:
                                  Theme.of(context).textTheme.caption!.color),
                        ),
                      ),
                    );
                  }
                }))
      ],
    );
  }
}
