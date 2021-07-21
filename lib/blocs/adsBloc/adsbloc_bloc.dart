import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/models/ads_model.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';
import 'package:realcallerapp/repositories/phone_auth_repository.dart';

part 'adsbloc_event.dart';
part 'adsbloc_state.dart';

class AdsblocBloc extends Bloc<AdsblocEvent, AdsblocState> {
  FirestoreRepo _firestoreRepo = FirestoreRepo();
  PhoneAuthRepository phoneAuthRepository = PhoneAuthRepository();
  AdsblocBloc() : super(AdsblocInitial());

  @override
  Stream<AdsblocState> mapEventToState(
    AdsblocEvent event,
  ) async* {
    if (event is RequestAdsModel) {
      yield* getAllAdsDetailMapEventToState();
    } else if (event is UpdateAdsModel) {
      yield* updateAdDetailMapEventToState(event: event);
    }
  }

  Stream<AdsblocState> getAllAdsDetailMapEventToState() async* {
    try {
      yield GetAllAdsDetailLoading();
      String userID = phoneAuthRepository.getLoggedInUserID();
      List<AdsModel> listOfAdsModel =
          await _firestoreRepo.getUserAds(userId: userID);
      yield GetAllAdsDetailSuccess(listOfAdsModel: listOfAdsModel);
    } catch (e) {
      yield GetAllAdsDetailFailed(message: e.toString());
    }
  }

  Stream<AdsblocState> updateAdDetailMapEventToState(
      {required UpdateAdsModel event}) async* {
    try {
      yield UpdateUserAdLoading();
      String userID = phoneAuthRepository.getLoggedInUserID();
      bool isSuccess = await _firestoreRepo.updateUserAds(
          userID: userID, adsModel: event.adsModel);
      if (isSuccess) {
        yield UpdateUserAdSuccess();
      } else {
        yield UpdateUserAdFailed(message: "User Ad Update Failed.");
      }
    } catch (e) {
      yield UpdateUserAdFailed(message: e.toString());
    }
  }
}
