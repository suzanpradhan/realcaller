import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:realcallerapp/blocs/calllogbloc/calllogbloc_bloc.dart';
import 'package:realcallerapp/utils/extensions/string_extensions.dart';

class AllCallLogScreen extends StatefulWidget {
  @override
  _AllCallLogScreenState createState() => _AllCallLogScreenState();
}

class _AllCallLogScreenState extends State<AllCallLogScreen> {
  _callNumber(String number) async {
    bool res = (await FlutterPhoneDirectCaller.callNumber(number))!;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  CalllogblocBloc()..add(RequestAllCallLogEvent()))
        ],
        child: BlocConsumer<CalllogblocBloc, CalllogblocState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is AllCallLogLoaded) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ListView.builder(
                      itemCount: state.allCallLogs.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor:
                                          Theme.of(context).accentColor,
                                      child: Text(state.allCallLogs[index].name!
                                          .getInitials()),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(state.allCallLogs[index].name!),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text((state.allCallLogs[index].callType
                                            .toString()
                                            .split(".")
                                            .last
                                            .capitalize()))
                                      ],
                                    ),
                                  ],
                                ),
                                IconButton(
                                    icon: Icon(
                                      Icons.phone,
                                      size: 24,
                                      color: Color(0xffa1a1a1),
                                    ),
                                    onPressed: () {
                                      _callNumber(
                                          state.allCallLogs[index].number!);
                                    })
                              ],
                            ),
                          ),
                        );
                      }),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
}
