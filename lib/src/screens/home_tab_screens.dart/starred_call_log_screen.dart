import 'package:flutter/material.dart';

class StarredCallLog extends StatefulWidget {
  @override
  _StarredCallLogState createState() => _StarredCallLogState();
}

class _StarredCallLogState extends State<StarredCallLog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text(
          "No Call logs.",
          style: TextStyle(
              fontFamily: "GilroyLight",
              color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
    );
  }
}
