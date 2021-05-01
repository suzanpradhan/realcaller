import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'contactbloc_event.dart';
part 'contactbloc_state.dart';

class ContactblocBloc extends Bloc<ContactblocEvent, ContactblocState> {
  ContactblocBloc() : super(ContactblocInitial());

  @override
  Stream<ContactblocState> mapEventToState(
    ContactblocEvent event,
  ) async* {
    if (event is RequestAllContactsEvent) {
      try {
        Iterable<Contact> contacts = await ContactsService.getContacts();
        debugPrint(contacts.elementAt(0).avatar.toString());
        if (contacts.length == 0) {
          yield NoContacts(message: "No Contacts Found.");
        } else {
          yield ContactsLoaded(contacts: contacts);
        }
      } catch (e) {
        yield ContactsLoadFailed(errorMessage: e.toString());
      }
    }
  }
}
