import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xfffafafa),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Color(0xff0d0d0d),
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
                backgroundImage: NetworkImage(
                    "https://wallpaperaccess.com/full/2213424.jpg"),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Alex Brooker",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              color: Color(0xfff1f1f1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(
                        Icons.phone,
                        size: 20,
                        color: Color(0xff00ca78),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Call",
                        style: TextStyle(color: Color(0xff00ca78)),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.message, size: 20, color: Color(0xff00ca78)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Message",
                          style: TextStyle(color: Color(0xff00ca78)))
                    ],
                  ),
                  Column(
                    children: [
                      Icon(Icons.block, size: 20, color: Color(0xff00ca78)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("Block", style: TextStyle(color: Color(0xff00ca78)))
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
                Container(
                  width: double.infinity,
                  color: Color(0xfff1f1f1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("9832432948",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff0d0d0d),
                          )),
                      Text("Mobile Provider1",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff707070),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  width: double.infinity,
                  color: Color(0xfff1f1f1),
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("9832432948",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xff0d0d0d),
                          )),
                      Text("Mobile Provider1",
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff707070),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Call History",
                    style: TextStyle(color: Color(0xff0d0d0d), fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 14,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfff1f1f1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("12:28 PM",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff0d0d0d),
                                )),
                            Text("9832432948",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff707070),
                                )),
                          ],
                        ),
                        Icon(
                          Icons.phone,
                          size: 20,
                          color: Color(0xff707070),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xfff1f1f1),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("12:28 PM",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xff0d0d0d),
                                )),
                            Text("9832432948",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color(0xff707070),
                                )),
                          ],
                        ),
                        Icon(
                          Icons.phone,
                          size: 20,
                          color: Color(0xff707070),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
