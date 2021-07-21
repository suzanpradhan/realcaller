import 'package:country_code_picker/country_code_picker.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/locationChecker/locationchecker_bloc.dart';
import 'package:realcallerapp/blocs/locationSearch/locationsearch_bloc.dart';
import 'package:realcallerapp/blocs/locationService/locationservice_bloc.dart';
import 'package:realcallerapp/models/basicuser.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/service/location_service.dart';
import 'package:realcallerapp/src/screens/error_screens.dart/location_error_screen.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';
import 'package:realcallerapp/utils/constants/custom_colors.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  int searchOptionValue = 1;
  late CountryCode _selectedCountryCode;

  LocationService locationService = LocationService();
  TextEditingController searchTextController = TextEditingController();
  String currentUserLocation = "Loading...";

  _callNumber(String number) async {
    bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
  }

  showTestDialog({required BasicUser user}) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).bottomAppBarColor,
                  borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24,
                  ),
                  (user.profileUrl == "")
                      ? CircleAvatar(
                          backgroundImage:
                              AssetImage("assets/images/no_image.png"),
                          radius: 42,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(user.profileUrl),
                          radius: 42,
                        ),
                  ListTile(
                    title: Text(
                      "Name: " + user.firstname + " " + user.lastname,
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Email: " + user.email,
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Phone: " + user.phone,
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "City: " + user.address.split(" ")[0],
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Country: " + user.address.split(" ")[1],
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.phone,
                            color: CustomColors.purpleLight,
                          ),
                          onPressed: () {
                            _callNumber(user.phone);
                          }),
                      SizedBox(
                        width: 18,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (BuildContext context) {
                            return MessageRoomScreen(
                                smsListing: SmsListing(
                                    name: user.firstname + " " + user.lastname,
                                    userProfileImage: (user.profileUrl == "")
                                        ? AssetImage(
                                            "assets/images/no_image.png")
                                        : NetworkImage(user.profileUrl)
                                            as ImageProvider));
                          }));
                        },
                        icon: Icon(
                          Icons.message,
                          color: CustomColors.purpleDarkFaded,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 14,
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocationcheckerBloc()..add(CheckLocationEvent()),
        ),
        BlocProvider(
          create: (context) => LocationserviceBloc(),
        ),
        BlocProvider(create: (context) => LocationsearchBloc())
      ],
      child: BlocConsumer<LocationcheckerBloc, LocationcheckerState>(
        listener: (context, state) {
          if (state is LocationPermissionAllowed) {
            BlocProvider.of<LocationserviceBloc>(context)
              ..add(GetCurrentUserLocation());
          }
        },
        builder: (context, state) {
          if (state is LocationCheckerLoading) {
            return Center(
                child: CircularProgressIndicator(
              color: CustomColors.purpleLight,
              strokeWidth: 1,
            ));
          } else if (state is LocationDisabledState) {
            return LocationErrorScreen(
              errorMessage:
                  "You have to enable the location to see others too.",
              buttonText: "Enable Location",
              onClickFuntion: () {
                locationService.openLocationStatusSettings();
              },
            );
          } else if (state is LocationPermissionDenied) {
            return LocationErrorScreen(
              errorMessage: "Realcaller needs your location permission.",
              buttonText: "Allow Location",
              onClickFuntion: () {
                locationService.openLocationPermissionSettings();
              },
            );
          } else if (state is LocationPermissionAllowed) {
            return BlocConsumer<LocationserviceBloc, LocationserviceState>(
              listener: (context, state) {
                if (state is CurrentUserLocationUpdatedState) {
                  setState(() {
                    currentUserLocation =
                        "${state.address.locality} ${state.address.country}";
                  });
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child:
                          BlocBuilder<LocationsearchBloc, LocationsearchState>(
                        builder: (context, state) {
                          return Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .appBarTheme
                                    .backgroundColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      // InkWell(
                                      //   onTap: () {},
                                      //   child: Padding(
                                      //     padding:
                                      //         const EdgeInsets.only(left: 14),
                                      //     child: InkWell(
                                      //       onTap: () => Scaffold.of(context)
                                      //           .openDrawer(),
                                      //       child: Icon(
                                      //         Icons.menu,
                                      //         size: 20,
                                      //         color:
                                      //             IconTheme.of(context).color,
                                      //       ),
                                      //     ),
                                      //   ),
                                      // ),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      (searchOptionValue == 1)
                                          ? Container(
                                              child: CountryCodePicker(
                                                initialSelection: 'IT',
                                                flagWidth: 14,

                                                favorite: ['+39', 'FR'],
                                                // optional. Shows only country name and flag
                                                showCountryOnly: false,
                                                padding: EdgeInsets.zero,
                                                // optional. Shows only country name and flag when popup is closed.
                                                showOnlyCountryWhenClosed: true,
                                                // optional. aligns the flag and the Text left
                                                alignLeft: false,
                                                onInit: (code) {
                                                  _selectedCountryCode = code!;
                                                },
                                                onChanged: (code) {
                                                  setState(() {
                                                    _selectedCountryCode = code;
                                                  });
                                                },
                                              ),
                                            )
                                          : Container(),
                                      Expanded(
                                        child: TextField(
                                          controller: searchTextController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: (searchOptionValue == 1)
                                                  ? "Enter number..."
                                                  : "Enter name",
                                              hintStyle: TextStyle(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .color)),
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (searchTextController
                                              .text.isNotEmpty) {
                                            if (searchOptionValue == 1) {
                                              BlocProvider.of<
                                                  LocationsearchBloc>(context)
                                                ..add(SearchUserByNumber(
                                                    countryCode:
                                                        _selectedCountryCode,
                                                    number: searchTextController
                                                        .text));
                                            } else {
                                              BlocProvider.of<
                                                  LocationsearchBloc>(context)
                                                ..add(SearchUserWithLocation(
                                                    searchvalue:
                                                        searchTextController
                                                            .text));
                                            }
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6)),
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 8),
                                          child: Icon(
                                            EvaIcons.search,
                                            color: CustomColors.purpleDarkFaded,
                                          ),
                                        ),
                                      ),
                                      PopupMenuButton(
                                          icon: Icon(Icons.more_vert),
                                          padding: EdgeInsets.zero,
                                          onSelected: (int value) {
                                            setState(() {
                                              searchOptionValue = value;
                                            });
                                          },
                                          itemBuilder: (context) => [
                                                PopupMenuItem(
                                                    value: 1,
                                                    child: Text(
                                                        "Search By Number")),
                                                PopupMenuItem(
                                                    value: 2,
                                                    child:
                                                        Text("Search By User"))
                                              ])
                                    ],
                                  )
                                ],
                              ));
                        },
                      ),
                    ),
                    BlocConsumer<LocationsearchBloc, LocationsearchState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        if (state is LocationSearchLoaded) {
                          return Expanded(
                            child: ListView.builder(
                                itemCount: state.listOfUser.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  // Contact _contact = state.contacts.elementAt(index);
                                  // ImageProvider _contactImage =
                                  //     (_contact.avatar != null &&
                                  //             _contact.avatar!.isNotEmpty &&
                                  //             _contact.avatar.toString() != "[]")
                                  //         ? MemoryImage(
                                  //             state.contacts.elementAt(index).avatar!)
                                  //         : AssetImage(ProfileImages().getRandomImage())
                                  //             as ImageProvider;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                    child: InkWell(
                                      onTap: () {
                                        showTestDialog(
                                            user: state.listOfUser[index]);
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 14,
                                            bottom: 12,
                                            top: 12,
                                            right: 8),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Theme.of(context)
                                                .appBarTheme
                                                .backgroundColor),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                        onTap: () {
                                                          // showTestDialog(
                                                          //     userProfile: _contactImage);
                                                        },
                                                        child: (state
                                                                    .listOfUser[
                                                                        index]
                                                                    .profileUrl ==
                                                                "")
                                                            ? CircleAvatar(
                                                                radius: 24,
                                                                backgroundImage:
                                                                    AssetImage(
                                                                        "assets/images/no_image.png"),
                                                              )
                                                            : CircleAvatar(
                                                                radius: 24,
                                                                backgroundImage:
                                                                    NetworkImage(state
                                                                        .listOfUser[
                                                                            index]
                                                                        .profileUrl),
                                                              )),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            state
                                                                    .listOfUser[
                                                                        index]
                                                                    .firstname +
                                                                " " +
                                                                state
                                                                    .listOfUser[
                                                                        index]
                                                                    .lastname,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                fontSize: 16,
                                                                color: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodyText1!
                                                                    .color,
                                                                fontFamily:
                                                                    "GilroyLight"),
                                                          ),
                                                          SizedBox(
                                                            height: 8,
                                                          ),
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                EvaIcons
                                                                    .pinOutline,
                                                                size: 14,
                                                                color: CustomColors
                                                                    .purpleLight,
                                                              ),
                                                              SizedBox(
                                                                width: 4,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  state
                                                                      .listOfUser[
                                                                          index]
                                                                      .address,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  maxLines: 2,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          14,
                                                                      color: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .bodyText1!
                                                                          .color,
                                                                      fontFamily:
                                                                          "GilroyLight"),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                    icon: Icon(
                                                      EvaIcons.navigation2,
                                                      color: CustomColors
                                                          .purpleLight,
                                                    ),
                                                    onPressed: () {
                                                      // _callNumber(_contact.phones!
                                                      //     .elementAt(0)
                                                      //     .value!);
                                                    }),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          );
                        } else if (state is LocationSearchLaodFailed) {
                          return Center(
                            child: Text(state.message),
                          );
                        } else {
                          return Center(
                              child: Text("Search people to see the location.",
                                  style: TextStyle(
                                      fontFamily: "GilroyLight",
                                      color: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .color)));
                        }
                      },
                    )
                  ],
                );
              },
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: CustomColors.purpleLight,
              strokeWidth: 1,
            ));
          }
        },
      ),
    );
  }
}
