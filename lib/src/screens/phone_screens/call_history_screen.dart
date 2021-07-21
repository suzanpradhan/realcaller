import 'package:date_time_format/date_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realcallerapp/repositories/call_log_repo.dart';
import 'package:realcallerapp/blocs/call_history_bloc/call_history_bloc_bloc.dart';

class CallHistoryScreen extends StatefulWidget {
  final String phone;
  CallHistoryScreen({required this.phone});
  @override
  _CallHistoryScreenState createState() => _CallHistoryScreenState();
}

class _CallHistoryScreenState extends State<CallHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => CallHistoryBlocBloc()
              ..add(RequestAllCallLogOfSpecificPhone(phone: widget.phone)))
      ],
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Theme.of(context).primaryIconTheme.color,
            ),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: BlocConsumer<CallHistoryBlocBloc, CallHistoryBlocState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is AllCallLogLoadedOfPhone) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Container(
                        child: Text(
                          "Call History",
                          style: TextStyle(
                              fontFamily: "GilroyLight",
                              fontSize: 28,
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: state.allCallLogs.length,
                          itemBuilder: (BuildContext context, int index) {
                            String elapsedTime = DateTimeFormat.relative(
                                DateTime.fromMillisecondsSinceEpoch(
                                    state.allCallLogs[index].timestamp!),
                                formatAfter: Duration(days: 1),
                                format: 'M j, H:i a');
                            String callTime = DateTimeFormat.relative(
                                DateTime.now().subtract(Duration(
                                    seconds:
                                        state.allCallLogs[index].duration!)),
                                abbr: true);
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          elapsedTime,
                                          style: TextStyle(
                                              fontFamily: "GilroyLight",
                                              fontSize: 20,
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1!
                                                  .color),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              state.allCallLogs[index].number!,
                                              style: TextStyle(
                                                  fontFamily: "GilroyLight",
                                                  fontSize: 14,
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .caption!
                                                      .color),
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            CallLogRepo.getCallTypeIcon(
                                                callType: state
                                                    .allCallLogs[index]
                                                    .callType!)
                                          ],
                                        )
                                      ],
                                    ),
                                    Text(
                                      callTime,
                                      style: TextStyle(
                                          fontFamily: "GilroyLight",
                                          fontSize: 16),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                );
              } else if (state is NoCallLogsOfPhone) {
                return Center(
                  child: Text(
                    state.message,
                    style: TextStyle(
                        fontFamily: "GilroyLight",
                        color: Theme.of(context).textTheme.bodyText1!.color),
                  ),
                );
              } else {
                return CircularProgressIndicator(
                  strokeWidth: 1,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
