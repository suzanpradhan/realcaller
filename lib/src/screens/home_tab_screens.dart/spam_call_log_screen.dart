import 'package:flutter/material.dart';

class SpamCallLog extends StatefulWidget {
  @override
  _SpamCallLogState createState() => _SpamCallLogState();
}

class _SpamCallLogState extends State<SpamCallLog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("No Spam Call logs."),
      ),
    );
  }
}
