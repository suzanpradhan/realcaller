import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:realcallerapp/repositories/contacts_repo_2.dart';

part 'searchcontact_event.dart';
part 'searchcontact_state.dart';

class SearchcontactBloc extends Bloc<SearchcontactEvent, SearchcontactState> {
  final ContactsRepo2 contactsRepo2 = ContactsRepo2();
  SearchcontactBloc() : super(SearchcontactInitial());

  @override
  Stream<SearchcontactState> mapEventToState(
    SearchcontactEvent event,
  ) async* {
    if (event is RequestAllContacts) {
      yield* getAllContactMapToState();
    } else if (event is RequestContactsBySearch) {
      yield ContactSearchLoading();
      yield* getContactsBySearchMapToState(searchValue: event.searchValue);
    }
  }

  Stream<SearchcontactState> getAllContactMapToState() async* {
    try {
      List<Contact> contacts = await contactsRepo2.getAllContacts();
      if (contacts.isNotEmpty) {
        yield ContactSearchLoaded(contacts: contacts);
      } else {
        yield ContactSearchNoContacts(message: "No Contacts.");
      }
    } catch (e) {
      yield ContactSearchLoadFailed(message: "Fetching Contacts Failed!");
    }
  }

  Stream<SearchcontactState> getContactsBySearchMapToState(
      {required String searchValue}) async* {
    try {
      List<Contact> contacts =
          await contactsRepo2.getContactsBySearch(searchValue: searchValue);
      if (contacts.isNotEmpty) {
        yield ContactSearchLoaded(contacts: contacts);
      } else {
        yield ContactSearchNoContacts(message: "No Contacts.");
      }
    } catch (e) {
      yield ContactSearchLoadFailed(message: "Fetching Contacts Failed!");
    }
  }
}
