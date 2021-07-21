import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/blocs/search_contact/searchcontact_bloc.dart';
import 'package:realcallerapp/models/smsListing.dart';
import 'package:realcallerapp/repositories/contacts_repo_2.dart';
import 'package:realcallerapp/src/screens/message_screens/message_room_screen.dart';
import 'package:realcallerapp/utils/constants/profiles_images.dart';

class NewMessageScreen extends StatefulWidget {
  @override
  _NewMessageScreenState createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  late SearchcontactBloc searchcontactBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SearchcontactBloc()..add(RequestAllContacts()),
        child: Scaffold(
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
              automaticallyImplyLeading: false,
              titleSpacing: 0,
              title: Text(
                "New conversation",
                style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).textTheme.bodyText1!.color),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    color: Theme.of(context).appBarTheme.color,
                    height: 50,
                    width: double.infinity,
                    child: TextField(
                      onChanged: (value) {
                        searchcontactBloc
                          ..add(RequestContactsBySearch(searchValue: value));
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search contacts...",
                          hintStyle: TextStyle(
                              fontFamily: "GilroyLight",
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontSize: 18)),
                      style: TextStyle(
                        fontFamily: "GilroyLight",
                        color: Theme.of(context).textTheme.caption!.color,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  BlocConsumer<SearchcontactBloc, SearchcontactState>(
                    listener: (context, state) {
                      if (state is ContactSearchLoaded) {
                        setState(() {
                          searchcontactBloc =
                              BlocProvider.of<SearchcontactBloc>(context);
                        });
                      }
                    },
                    builder: (context, state) {
                      if (state is ContactSearchLoaded) {
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.contacts.length,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MessageRoomScreen(
                                                    smsListing: SmsListing(
                                                        id: 1,
                                                        name: state
                                                            .contacts[index]
                                                            .phones!
                                                            .first
                                                            .value!,
                                                        recentMessage: "",
                                                        recentMessageTime:
                                                            DateTime.now()
                                                                .toString(),
                                                        userProfileImage:
                                                            AssetImage(
                                                                ProfileImages()
                                                                    .getRandomImage()),
                                                        time: 0))));
                                      },
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            InkWell(
                                                onTap: () {
                                                  // showTestDialog(
                                                  //     userProfile: snapshot
                                                  //         .data?.userProfileImage);
                                                },
                                                child: FutureBuilder(
                                                    future: ContactsRepo2
                                                        .getContactProfileImage(
                                                            contact:
                                                                state.contacts[
                                                                    index]),
                                                    builder: (BuildContext
                                                            context,
                                                        AsyncSnapshot<
                                                                ImageProvider<
                                                                    Object>>
                                                            snapshot) {
                                                      if (snapshot.hasData) {
                                                        return CircleAvatar(
                                                          radius: 28,
                                                          backgroundImage:
                                                              snapshot.data!,
                                                        );
                                                      } else {
                                                        return CircleAvatar(
                                                          radius: 28,
                                                        );
                                                      }
                                                    })),
                                            SizedBox(
                                              width: 14,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  // CONTACT NAME
                                                  Text(
                                                    (state.contacts[index]
                                                                .displayName !=
                                                            null)
                                                        ? state.contacts[index]
                                                            .displayName!
                                                        : "",
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Theme.of(context)
                                                            .textTheme
                                                            .bodyText1!
                                                            .color,
                                                        fontFamily:
                                                            "GilroyLight"),
                                                  ),
                                                  SizedBox(
                                                    height: 4,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        );
                      } else if (state is ContactSearchLoading) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      } else if (state is ContactSearchLoadFailed) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                  fontFamily: "GilroyLight",
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                            ),
                          ),
                        );
                      } else if (state is ContactSearchNoContacts) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Container(
                            child: Text(
                              state.message,
                              style: TextStyle(
                                  fontFamily: "GilroyLight",
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .color),
                            ),
                          ),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            )));
  }
}
