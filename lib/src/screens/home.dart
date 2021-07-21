import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/appThemeChanger/appthemechanger_bloc.dart';
import 'package:realcallerapp/blocs/calllogbloc/calllogbloc_bloc.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';
import 'package:realcallerapp/src/screens/message_screens/new_message_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/contacts_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/home_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/location_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/message_screen.dart';
import 'package:realcallerapp/src/screens/navigation_screens/settings_screen.dart';
import 'package:realcallerapp/src/screens/side_navigations_screens/discover_people.dart';
import 'package:realcallerapp/src/screens/side_navigations_screens/who_can_see_me.dart';
import 'package:realcallerapp/utils/constants/app_theme_enums.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';
import 'package:realcallerapp/src/screens/phone_screens/realcaller_dailer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  late List<Widget> _navigationScreens;
  late List<Widget> _floatingButtons;
  // late StreamSubscription streamSubscription;

  int _currentIndex = 0;
  PhoneAuthRepository _phoneAuthRepository = PhoneAuthRepository();
  FirestoreRepo _firestoreRepo = FirestoreRepo();
  late String userID;

  // _callNumber(String number) async {
  //   bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
  // }

  showDialer() {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Colors.black,
            child: RealCallerDialer(),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    userID = _phoneAuthRepository.getLoggedInUserID();
    _navigationScreens = <Widget>[
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CalllogblocBloc(),
          ),
        ],
        child: HomeScreen(),
      ),
      MessageScreen(),
      LocationScreen(),
      ContactsScreen(),
      SettingsScreen()
    ];
    _floatingButtons = <Widget>[
      FloatingActionButton(
        onPressed: () {
          showDialer();
        },
        child: Icon(
          Icons.dialpad,
          color: Colors.white,
        ),
        backgroundColor: CustomColors.accentPurpleDark,
      ),
      FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => NewMessageScreen()));
        },
        child: Icon(
          EvaIcons.edit,
          color: Colors.white,
        ),
        backgroundColor: CustomColors.accentPurpleDark,
      ),
      Container(),
      Container(),
      Container()
    ];
    this._currentIndex = 0;
    // streamSubscription =
    //     phoneStateCallEvent.listen((PhoneStateCallEvent event) {
    //   print('Call is Incoming or Connected' + event.stateC);
    //   //event.stateC has values "true" or "false"
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
            value: BlocProvider.of<AppthemechangerBloc>(context)
              ..add(CheckCurrentAppTheme())),
      ],
      child: BlocConsumer<AppthemechangerBloc, AppthemechangerState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is AppThemeLoaded) {
            return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                drawer: FutureBuilder(
                    future: _firestoreRepo.getUserData(userID),
                    builder: (BuildContext context,
                        AsyncSnapshot<BasicUser> snapshot) {
                      return Drawer(
                        child: Container(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: ListView(
                            children: [
                              DrawerHeader(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 32,
                                      backgroundImage: (snapshot
                                                      .data?.profileUrl !=
                                                  "" &&
                                              snapshot.data?.profileUrl != null)
                                          ? NetworkImage(
                                              "${snapshot.data?.profileUrl}",
                                            )
                                          : AssetImage(
                                                  "assets/images/no_image.png")
                                              as ImageProvider,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${snapshot.data?.firstname} ${snapshot.data?.lastname}",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${snapshot.data?.phone}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: CustomColors.greyDark,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              border: Border.all(
                                                  width: 1,
                                                  color: CustomColors.grey)),
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            icon: Icon(
                                              Icons.edit,
                                              color: CustomColors.greyDark,
                                              size: 24,
                                            ),
                                            onPressed: () {},
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              ListTile(
                                title: Text(
                                  "Upgrade To Premium",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(
                                  EvaIcons.eye,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                                title: Text("Who's seen my profile"),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          WhoCanSeeMe()));
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  EvaIcons.compass,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                                title: Text("Discover People"),
                                onTap: () {
                                  Navigator.of(context).push(CupertinoPageRoute(
                                      builder: (BuildContext context) =>
                                          DiscoverPeopleScreen()));
                                },
                              ),
                              ListTile(
                                leading: Icon(
                                  EvaIcons.bell,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                                title: Text("Notification"),
                                onTap: () {},
                              ),
                              ListTile(
                                leading: Icon(
                                  EvaIcons.share,
                                  color:
                                      Theme.of(context).primaryIconTheme.color,
                                ),
                                title: Text("Invite Friend"),
                                onTap: () {},
                              ),
                              ListTile(
                                title: Text(
                                  "Dark mode",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                trailing: CupertinoSwitch(
                                    activeColor: Color(0xff0d0d0d),
                                    value: state.isDarkMode,
                                    onChanged: (value) {
                                      print(value);
                                      setState(() {
                                        if (value) {
                                          BlocProvider.of<AppthemechangerBloc>(
                                                  context)
                                              .add(ChangeAppTheme(
                                                  appThemeEnum:
                                                      AppThemeEnum.Dark));
                                        } else {
                                          BlocProvider.of<AppthemechangerBloc>(
                                                  context)
                                              .add(ChangeAppTheme(
                                                  appThemeEnum:
                                                      AppThemeEnum.Light));
                                        }
                                      });
                                    }),
                                onTap: () {},
                              ),
                              ListTile(
                                title: Text(
                                  "FAQ",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                extendBody: true,
                bottomNavigationBar: CurvedNavigationBar(
                  backgroundColor: Colors.transparent,
                  color: Theme.of(context).bottomAppBarColor,
                  items: [
                    Icon(
                      EvaIcons.home,
                      color: Theme.of(context)
                          .bottomNavigationBarTheme
                          .selectedItemColor,
                    ),
                    Icon(EvaIcons.messageCircle,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor),
                    Icon(EvaIcons.pin,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor),
                    Icon(EvaIcons.people,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor),
                    Icon(EvaIcons.settings,
                        color: Theme.of(context)
                            .bottomNavigationBarTheme
                            .selectedItemColor)
                  ],
                  onTap: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
                floatingActionButton: _floatingButtons[_currentIndex],
                body: SafeArea(
                  child: _navigationScreens[_currentIndex],
                  bottom: false,
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: CustomColors.purpleLight,
                strokeWidth: 1,
              ),
            );
          }
        },
      ),
    );
  }
}
