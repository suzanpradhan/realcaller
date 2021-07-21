import 'package:flutter/material.dart';

class WhoCanSeeMe extends StatefulWidget {
  const WhoCanSeeMe({Key? key}) : super(key: key);

  @override
  _WhoCanSeeMeState createState() => _WhoCanSeeMeState();
}

class _WhoCanSeeMeState extends State<WhoCanSeeMe> {
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
          "Who's seen my profile",
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "No one has seen your profile.",
              style: TextStyle(
                  fontFamily: "GilroyLight",
                  fontSize: 14,
                  color: Theme.of(context).textTheme.bodyText1!.color),
            )
          ],
        ),
      ),
    );
  }
}
