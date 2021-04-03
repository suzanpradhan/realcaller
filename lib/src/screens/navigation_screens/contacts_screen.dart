import 'package:flutter/material.dart';
import 'package:realcallerapp/models/message.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
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
                  onTap: () {},
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
                                Text(
                                  messageData[index].username,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Color(0xff00ca78),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.message,
                              color: Color(0xff00ca78),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
