part of 'settingsmodel_bloc.dart';

abstract class SettingsmodelState extends Equatable {
  const SettingsmodelState();

  @override
  List<Object> get props => [];
}

class SettingsmodelInitial extends SettingsmodelState {}

class SettingsDetailLoading extends SettingsmodelState {}

class SettingsDetailSuccess extends SettingsmodelState {
  final SettingsModel settingsModel;
  SettingsDetailSuccess({required this.settingsModel});

  @override
  List<Object> get props => [settingsModel];
}

class SettingsDetailFailed extends SettingsmodelState {
  final String message;
  SettingsDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateSettingsLoading extends SettingsmodelState {}
