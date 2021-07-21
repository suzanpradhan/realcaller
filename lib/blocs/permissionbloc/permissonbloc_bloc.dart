import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/service/app_permissions.dart';

part 'permissonbloc_event.dart';
part 'permissonbloc_state.dart';

class PermissonblocBloc extends Bloc<PermissonblocEvent, PermissonblocState> {
  AppPermission appPermission;
  PermissonblocBloc({required this.appPermission})
      : super(PermissonblocInitial());

  @override
  Stream<PermissonblocState> mapEventToState(
    PermissonblocEvent event,
  ) async* {
    if (event is RequestAllPermission) {
    } else if (event is AllPermissionGrantedEvent) {
      yield RequestAllPermissionLoaded();
    }
  }
}
