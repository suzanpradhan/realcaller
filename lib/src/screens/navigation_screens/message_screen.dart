import 'package:flutter/material.dart';
import 'package:realcallerapp/models/message.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';

class MessageScreen extends StatefulWidget {
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Color(0xfffafafa),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xfff1f1f1),
                      offset: Offset(0, 3),
                      blurRadius: 2)
                ]),
            child: Row(
              children: [
                InkWell(
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: Icon(
                      Icons.menu,
                      size: 20,
                      color: Color(0xff0d0d0d),
                    ),
                  ),
                ),
                SizedBox(
                  width: 14,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none, hintText: "Search"),
                    style: TextStyle(fontSize: 16, color: Color(0xff0d0d0d)),
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
                      color: Color(0xff0d0d0d),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: messageData.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: InkWell(
                    onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                      return MessageRoomScreen();
                    })),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                    messageData[index].profileImageUrl),
                              ),
                              SizedBox(
                                width: 14,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(messageData[index].username),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(messageData[index].recentMessage)
                                ],
                              ),
                            ],
                          ),
                          Text(messageData[index].dateTime)
                        ],
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
