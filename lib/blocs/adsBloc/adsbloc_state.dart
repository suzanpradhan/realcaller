part of 'adsbloc_bloc.dart';

abstract class AdsblocState extends Equatable {
  const AdsblocState();

  @override
  List<Object> get props => [];
}

class AdsblocInitial extends AdsblocState {}

class GetAllAdsDetailLoading extends AdsblocState {}

class GetAllAdsDetailSuccess extends AdsblocState {
  final List<AdsModel> listOfAdsModel;
  GetAllAdsDetailSuccess({required this.listOfAdsModel});

  @override
  List<Object> get props => [listOfAdsModel];
}

class GetAllAdsDetailFailed extends AdsblocState {
  final String message;
  GetAllAdsDetailFailed({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateUserAdLoading extends AdsblocState {}

class UpdateUserAdSuccess extends AdsblocState {}

class UpdateUserAdFailed extends AdsblocState {
  final String message;
  UpdateUserAdFailed({required this.message});

  @override
  List<Object> get props => [message];
}
