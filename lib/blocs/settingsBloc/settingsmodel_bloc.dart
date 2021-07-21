import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/models/hive_models/settings_model.dart';
import 'package:realcallerapp/repositories/settings_repository.dart';

part 'settingsmodel_event.dart';
part 'settingsmodel_state.dart';

class SettingsmodelBloc extends Bloc<SettingsmodelEvent, SettingsmodelState> {
  SettingsRepo settingsRepo = SettingsRepo();
  SettingsmodelBloc() : super(SettingsmodelInitial());

  @override
  Stream<SettingsmodelState> mapEventToState(
    SettingsmodelEvent event,
  ) async* {
    if (event is RequestSettingsDetails) {
      yield SettingsDetailLoading();
      yield* getSettingsDetailMapEventToState();
    } else if (event is UpdateSettingDetails) {
      yield UpdateSettingsLoading();
      yield* updateSettingsDetailMapEventToState(event: event);
    }
  }

  Stream<SettingsmodelState> getSettingsDetailMapEventToState() async* {
    try {
      SettingsModel settingsModel = await settingsRepo.getSettingsModel();
      yield SettingsDetailSuccess(settingsModel: settingsModel);
    } catch (e) {
      yield SettingsDetailFailed(message: e.toString());
    }
  }

  Stream<SettingsmodelState> updateSettingsDetailMapEventToState(
      {required UpdateSettingDetails event}) async* {
    try {
      SettingsModel settingsModel = await settingsRepo.updateSettingsModel(
          settingsModel: event.settingsModel);
      yield SettingsDetailSuccess(settingsModel: settingsModel);
    } catch (e) {
      yield SettingsDetailFailed(message: e.toString());
    }
  }
}
