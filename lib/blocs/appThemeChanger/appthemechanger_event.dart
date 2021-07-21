part of 'appthemechanger_bloc.dart';

abstract class AppthemechangerEvent extends Equatable {
  const AppthemechangerEvent();

  @override
  List<Object> get props => [];
}

class CheckCurrentAppTheme extends AppthemechangerEvent {}

class ChangeAppTheme extends AppthemechangerEvent {
  final AppThemeEnum appThemeEnum;

  const ChangeAppTheme({required this.appThemeEnum});

  @override
  List<Object> get props => [appThemeEnum];
}
