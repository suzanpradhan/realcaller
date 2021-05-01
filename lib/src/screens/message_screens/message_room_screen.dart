import 'package:flutter/material.dart';

class MessageRoomScreen extends StatefulWidget {
  @override
  _MessageRoomScreenState createState() => _MessageRoomScreenState();
}

class _MessageRoomScreenState extends State<MessageRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0xff707070),
          ),
        ),
        backgroundColor: Color(0xfffafafa),
        centerTitle: true,
        title: Text(
          "Alex Brooker",
          style: TextStyle(fontSize: 16, color: Color(0xff0d0d0d)),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(reverse: true, children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffe1e1e1)),
                          child: Text(
                            "Sed ut perspiciatis unde omnis",
                            textAlign: TextAlign.start,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xff00ca78)),
                            child: Text(
                              "iste natus error sit voluptatem accusantium doloremque laudantium",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(32, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Color(0xff00ca78)),
                            child: Text(
                              "doloremque laudantium",
                              textAlign: TextAlign.end,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(
                            "https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZXxlbnwwfHwwfA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80"),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xffe1e1e1)),
                          child: Text(
                            "Sed ut perspiciatis unde omnis",
                            textAlign: TextAlign.start,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: Color(0xffe1e1e1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ], borderRadius: BorderRadius.circular(8), color: Colors.white),
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Type a message",
                            hintStyle: TextStyle(color: Color(0xffa1a1a1))),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(8),
                        child: Icon(
                          Icons.send,
                          color: Color(0xff00ca78),
                          size: 20,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
