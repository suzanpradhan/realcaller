import 'package:flutter/material.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class LocationErrorScreen extends StatefulWidget {
  final String errorMessage;
  final String buttonText;
  final Function() onClickFuntion;
  const LocationErrorScreen(
      {Key? key,
      required this.buttonText,
      required this.errorMessage,
      required this.onClickFuntion})
      : super(key: key);

  @override
  _LocationErrorScreenState createState() => _LocationErrorScreenState();
}

class _LocationErrorScreenState extends State<LocationErrorScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, bottom: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 280,
            padding: EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/images/location_error_image.png"))),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            widget.errorMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: "GilroyLight",
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyText1!.color),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
              minWidth: double.infinity,
              height: 50,
              padding: EdgeInsets.all(6),
              color: CustomColors.purpleLight,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              elevation: 0,
              onPressed: widget.onClickFuntion,
              child: Text(
                widget.buttonText,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )),
        ],
      ),
    );
  }
}
