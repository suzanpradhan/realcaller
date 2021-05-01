import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/contactbloc/contactbloc_bloc.dart';
import 'package:realcallerapp/models/message.dart';

class ContactsScreen extends StatefulWidget {
  @override
  _ContactsScreenState createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  _callNumber(String number) async {
    bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  ContactblocBloc()..add(RequestAllContactsEvent()))
        ],
        child: BlocConsumer<ContactblocBloc, ContactblocState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is ContactsLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Color(0xfffafafa),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color(0xfff1f1f1),
                                offset: Offset(0, 3),
                                blurRadius: 2)
                          ]),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.only(left: 14),
                              child: Icon(
                                Icons.menu,
                                size: 20,
                                color: Color(0xff0d0d0d),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Search"),
                              style: TextStyle(
                                  fontSize: 16, color: Color(0xff0d0d0d)),
                            ),
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 14),
                              child: Icon(
                                Icons.more_vert,
                                size: 20,
                                color: Color(0xff0d0d0d),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: state.contacts.length,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          Contact _contact = state.contacts.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      child: Row(
                                        children: [
                                          (_contact.avatar != null &&
                                                  _contact.avatar!.isNotEmpty)
                                              ? CircleAvatar(
                                                  radius: 24,
                                                  backgroundImage: MemoryImage(
                                                      state.contacts
                                                          .elementAt(index)
                                                          .avatar!),
                                                )
                                              : CircleAvatar(
                                                  radius: 24,
                                                  child:
                                                      Text(_contact.initials()),
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .accentColor,
                                                ),
                                          SizedBox(
                                            width: 14,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  state.contacts
                                                      .elementAt(index)
                                                      .displayName!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                  style:
                                                      TextStyle(fontSize: 18),
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
                                            Icons.phone,
                                            color: Color(0xff00ca78),
                                          ),
                                          onPressed: () {
                                            _callNumber(_contact.phones!
                                                .elementAt(0)
                                                .value!);
                                          }),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Icon(
                                        Icons.message,
                                        color: Color(0xff00ca78),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                  )
                ],
              );
            } else if (state is NoContacts) {
              return Center(
                child: Container(
                  child: Text("No Contacts Found."),
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
