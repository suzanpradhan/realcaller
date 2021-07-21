import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'smslisting_event.dart';
part 'smslisting_state.dart';

class SmslistingBloc extends Bloc<SmslistingEvent, SmslistingState> {
  SmslistingBloc() : super(SmslistingInitial());

  @override
  Stream<SmslistingState> mapEventToState(
    SmslistingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
