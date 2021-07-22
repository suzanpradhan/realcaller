import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/models/spam_model.dart';
import 'package:realcallerapp/repositories/firebase_repository/firestore_repo.dart';

part 'spamuser_event.dart';
part 'spamuser_state.dart';

class SpamuserBloc extends Bloc<SpamuserEvent, SpamuserState> {
  final FirestoreRepo firestoreRepo = FirestoreRepo();
  SpamuserBloc() : super(SpamuserInitial());

  @override
  Stream<SpamuserState> mapEventToState(
    SpamuserEvent event,
  ) async* {
    if (event is RequestAllSpams) {
      yield AllUserSpamLoading();
      yield* getAllSpamUsersMapEventToState();
    }
  }

  Stream<SpamuserState> getAllSpamUsersMapEventToState() async* {
    try {
      Iterable<Contact> contacts =
          await ContactsService.getContacts(withThumbnails: false);
      // Iterable<Contact> iterableOfNotScannedUsers =
      //     await ContactsService.getContacts();
      // List<Contact> listOfNotScannedUsers = iterableOfNotScannedUsers.toList();
      if (contacts.isNotEmpty) {
        List<SpamModel> listOfContact =
            await firestoreRepo.getAllUserSpams(listOfContacts: contacts);
        if (listOfContact.length != 0) {
          yield AllUserSpamLoadSuccess(listOfContacts: listOfContact.toList());
        } else {
          yield AllUserSpamLoadFailed(message: "No Spams to show.");
        }
      } else {}
    } catch (e) {
      yield AllUserSpamLoadFailed(message: e.toString());
    }
  }
}
