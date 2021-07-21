import 'package:flutter/material.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/repositories/sms_repo.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:telephony/telephony.dart';

class MessageRoomScreen extends StatefulWidget {
  final SmsListing smsListing;
  MessageRoomScreen({required this.smsListing});
  @override
  _MessageRoomScreenState createState() => _MessageRoomScreenState();
}

class _MessageRoomScreenState extends State<MessageRoomScreen> {
  Telephony telephony = Telephony.instance;

  sendMessage({required String number, required String message}) {
    telephony.sendSms(to: number, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          widget.smsListing.name!,
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future:
                      SmsRepo().getMessagesOfAddress(widget.smsListing.name!),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<SmsMessage>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          physics: BouncingScrollPhysics(),
                          reverse: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 14),
                              child: Row(
                                mainAxisAlignment:
                                    (snapshot.data![index].type ==
                                            SmsType.MESSAGE_TYPE_INBOX)
                                        ? MainAxisAlignment.start
                                        : MainAxisAlignment.end,
                                children: [
                                  (snapshot.data![index].type ==
                                          SmsType.MESSAGE_TYPE_INBOX)
                                      ? CircleAvatar(
                                          radius: 15,
                                          backgroundImage: widget
                                              .smsListing.userProfileImage,
                                        )
                                      : Container(),
                                  SizedBox(
                                    width: 14,
                                  ),
                                  Flexible(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 14),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: (snapshot.data![index].type ==
                                                  SmsType.MESSAGE_TYPE_INBOX)
                                              ? Theme.of(context)
                                                  .appBarTheme
                                                  .backgroundColor
                                              : Theme.of(context)
                                                  .bottomNavigationBarTheme
                                                  .selectedItemColor),
                                      child: Text(
                                        snapshot.data![index].body!,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontFamily: "GilroyLight",
                                            color: (snapshot
                                                        .data![index].type ==
                                                    SmsType.MESSAGE_TYPE_INBOX)
                                                ? CustomColors.greyDark
                                                : Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          });
                    } else {
                      return Column(
                        children: [
                          Text(
                            "No Recent Messages",
                            style: TextStyle(
                                fontFamily: "GilroyLight",
                                color:
                                    Theme.of(context).textTheme.caption!.color,
                                fontSize: 14),
                          )
                        ],
                      );
                    }
                  }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Theme.of(context).appBarTheme.backgroundColor),
                height: 50,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.text,
                        style: TextStyle(
                            fontFamily: "GilroyLight",
                            fontSize: 16,
                            color:
                                Theme.of(context).textTheme.bodyText1!.color),
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
                          color: Theme.of(context)
                              .bottomNavigationBarTheme
                              .selectedItemColor,
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

  ListView buildListView() {
    return ListView(reverse: true, children: [
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
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
    ]);
  }
}
