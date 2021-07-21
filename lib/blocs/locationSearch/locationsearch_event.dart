part of 'locationsearch_bloc.dart';

abstract class LocationsearchEvent extends Equatable {
  const LocationsearchEvent();

  @override
  List<Object> get props => [];
}

class SearchUserWithLocation extends LocationsearchEvent {
  final String searchvalue;
  SearchUserWithLocation({required this.searchvalue});
  @override
  List<Object> get props => [searchvalue];
}

class SearchUserByNumber extends LocationsearchEvent {
  final CountryCode countryCode;
  final String number;
  SearchUserByNumber({required this.countryCode, required this.number});

  @override
  List<Object> get props => [countryCode, number];
}
