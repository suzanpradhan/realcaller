import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'dating app',
    home: home(),
  ));
}

class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: 500,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      color: Colors.yellow,
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: Colors.yellow,
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: Colors.yellow,
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: Colors.yellow,
                      height: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      color: Colors.white,
                      height: 50.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              // ListView(
              //   padding: const EdgeInsets.all(50),
              //   scrollDirection: Axis.horizontal,
              //   children: <Widget>[
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //       children: <Widget>[
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Container(
              //             color: Colors.blue,
              //             height: 80.0,
              //             width: 80.0,
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Container(
              //             color: Colors.blue,
              //             height: 80.0,
              //             width: 80.0,
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Container(
              //             color: Colors.blue,
              //             height: 80.0,
              //             width: 80.0,
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Container(
              //             color: Colors.blue,
              //             height: 80.0,
              //             width: 80.0,
              //           ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.all(15.0),
              //           child: Container(
              //             color: Colors.blue,
              //             height: 80.0,
              //             width: 80.0,
              //           ),
              //         ),
              //       ],
              //     )
              //   ],
              // ),
              // ListView(
              //   padding: const EdgeInsets.all(50),
              //   children: <Widget>[
              //     Container(
              //       height: 50.0,
              //       decoration: BoxDecoration(
              //         color: Colors.red,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Container(
              //       color: Colors.red,
              //       height: 50.0,
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Container(
              //       color: Colors.red,
              //       height: 50.0,
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Container(
              //       color: Colors.red,
              //       height: 50.0,
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Container(
              //       color: Colors.red,
              //       height: 50.0,
              //     ),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     Container(
              //       height: 50.0,
              //       decoration: BoxDecoration(
              //         color: Colors.red,
              //         borderRadius: BorderRadius.circular(8),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
