part of 'settingsmodel_bloc.dart';

abstract class SettingsmodelEvent extends Equatable {
  const SettingsmodelEvent();

  @override
  List<Object> get props => [];
}

class RequestSettingsDetails extends SettingsmodelEvent {}

class UpdateSettingDetails extends SettingsmodelEvent {
  final SettingsModel settingsModel;
  UpdateSettingDetails({required this.settingsModel});

  @override
  List<Object> get props => [settingsModel];
}
