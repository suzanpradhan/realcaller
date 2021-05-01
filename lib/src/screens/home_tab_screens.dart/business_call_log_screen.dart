import 'package:flutter/material.dart';

class BusinessCallLog extends StatefulWidget {
  @override
  _BusinessCallLogState createState() => _BusinessCallLogState();
}

class _BusinessCallLogState extends State<BusinessCallLog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("No Business Logs."),
      ),
    );
  }
}
