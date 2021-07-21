part of 'appthemechanger_bloc.dart';

abstract class AppthemechangerState extends Equatable {
  const AppthemechangerState();

  @override
  List<Object> get props => [];
}

class AppthemechangerInitial extends AppthemechangerState {}

class AppThemeLoaded extends AppthemechangerState {
  final bool isDarkMode;

  const AppThemeLoaded({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}

class AppThemeChanged extends AppthemechangerState {
  final bool isDarkMode;

  const AppThemeChanged({required this.isDarkMode});

  @override
  List<Object> get props => [isDarkMode];
}
