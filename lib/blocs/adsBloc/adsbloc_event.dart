part of 'adsbloc_bloc.dart';

abstract class AdsblocEvent extends Equatable {
  const AdsblocEvent();

  @override
  List<Object> get props => [];
}

class RequestAdsModel extends AdsblocEvent {
  final String userID;
  RequestAdsModel({required this.userID});

  @override
  List<Object> get props => [userID];
}

class UpdateAdsModel extends AdsblocEvent {
  final String userID;
  final AdsModel adsModel;
  UpdateAdsModel({required this.adsModel, required this.userID});

  @override
  List<Object> get props => [userID, adsModel];
}
