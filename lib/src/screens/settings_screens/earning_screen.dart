import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

class EarningScreen extends StatefulWidget {
  const EarningScreen({Key? key}) : super(key: key);

  @override
  _EarningScreenState createState() => _EarningScreenState();
}

class _EarningScreenState extends State<EarningScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.color,
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
          "Earn RealCoins",
          style: TextStyle(
              fontSize: 16,
              color: Theme.of(context).textTheme.bodyText1!.color),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdsCard(
                      size: size,
                      icon: EvaIcons.playCircle,
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    AdsCard(
                      size: size,
                      icon: EvaIcons.playCircle,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdsCard(
                      size: size,
                      icon: EvaIcons.playCircle,
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    AdsCard(
                      size: size,
                      icon: EvaIcons.playCircle,
                      onTap: () {},
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AdsCard(
                      size: size,
                      icon: EvaIcons.playCircle,
                      onTap: () {},
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    AdsCard(
                      size: size,
                      icon: EvaIcons.playCircle,
                      onTap: () {},
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}

class AdsCard extends StatelessWidget {
  const AdsCard({
    Key? key,
    required this.size,
    required this.icon,
    this.onTap,
  }) : super(key: key);

  final Size size;
  final IconData icon;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!;
      },
      child: Container(
        width: size.width * 0.45,
        height: size.height * 0.28,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Theme.of(context).accentIconTheme.color,
        ),
        child: Icon(
          icon,
          size: 50,
        ),
      ),
    );
  }
}
