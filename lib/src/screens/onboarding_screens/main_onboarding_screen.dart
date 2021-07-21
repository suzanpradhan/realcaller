import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:realcallerapp/repositories/firebase_repository/firebase_storage_repo.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';
import 'package:realcallerapp/src/screens/login_from_email.dart';
import 'package:realcallerapp/src/screens/login_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class MainOnboardingScreen extends StatefulWidget {
  @override
  _MainOnboardingScreenState createState() => _MainOnboardingScreenState();
}

class _MainOnboardingScreenState extends State<MainOnboardingScreen> {
  PageController _onboardingPageController = PageController();
  FirestoreRepo _firestoreRepo = FirestoreRepo();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  nextScreen() {
    _onboardingPageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.ease);
  }

  isFirstTimeComplete() async {
    var isFirstTime = await Hive.openBox('isFirstTimeBox');
    isFirstTime.put("value", 1);
  }

  checkSimCardLogin() async {
    // final List<SimCard>? simCards = await MobileNumber.getSimCards;
    // if (simCards == null || simCards.length == 0) {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    //     return LoginScreen();
    //   }));
    // } else {
    // bool status = false;
    // print("here");
    // for (SimCard simCard in simCards) {
    //   status = _firestoreRepo.checkPhoneInDb(
    //       "+${simCard.countryPhonePrefix!}${simCard.number!}");
    //   print(simCard.countryPhonePrefix);
    //   print(status);
    // }
    // if (status) {
    //   Navigator.of(context)
    //       .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
    //     return LoginFromEmail();
    //   }));
    // } else {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (BuildContext context) {
      return LoginScreen();
    }));
    // }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 100,
          height: 40,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                      "assets/images/logos/logo_realcaller_purple.png"))),
        ),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: PageView(
          physics: BouncingScrollPhysics(),
          controller: _onboardingPageController,
          children: [
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/page1_artwork.png"))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Know who's calling",
                                  style: TextStyle(
                                      fontFamily: "GilroyBold",
                                      fontSize: 20,
                                      color: CustomColors.purpleBlack)),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                  "The world’s best Caller ID will identify anyone calling you.",
                                  style: TextStyle(
                                      fontFamily: "GilroyLight",
                                      fontSize: 16,
                                      color: CustomColors.greyDark))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            nextScreen();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "GilroyLight",
                                  fontSize: 16),
                            ),
                          ),
                          color: CustomColors.accentPurpleDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          splashColor: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/page2_artwork.png"))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Chat, SMS & Calls - all in one place.",
                                  style: TextStyle(
                                      fontFamily: "GilroyBold",
                                      fontSize: 20,
                                      color: CustomColors.purpleBlack)),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                  "Organize your SMS, Call Logs into Personal, Other and Spam.",
                                  style: TextStyle(
                                      fontFamily: "GilroyLight",
                                      fontSize: 16,
                                      color: CustomColors.greyDark))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            nextScreen();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "GilroyLight",
                                  fontSize: 16),
                            ),
                          ),
                          color: CustomColors.accentPurpleDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          splashColor: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 350,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/page3_artwork.png"))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Share Location.",
                                  style: TextStyle(
                                      fontFamily: "GilroyBold",
                                      fontSize: 20,
                                      color: CustomColors.purpleBlack)),
                              SizedBox(
                                height: 6,
                              ),
                              Text("Share location to your close one.",
                                  style: TextStyle(
                                      fontFamily: "GilroyLight",
                                      fontSize: 16,
                                      color: CustomColors.greyDark))
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            isFirstTimeComplete();
                            checkSimCardLogin();
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: Text(
                              "Next",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "GilroyLight",
                                  fontSize: 16),
                            ),
                          ),
                          color: CustomColors.accentPurpleDark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          splashColor: Colors.white,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
