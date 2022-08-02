import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tasky/data/firebase_repo.dart';

import '../data/mesagemodel.dart';

part 'firebasegroupmessaging_state.dart';

class FirebasegroupmessagingCubit extends Cubit<FirebasegroupmessagingState> {
  FirebasegroupmessagingCubit() : super(FirebasegroupmessagingInitial());

  getChatMessages() {
    List<MessageId> msg = [];

    try {
      emit(FirebasegroupmessagingInitial());
      FirebaseFirestore.instance
          .collection("UserGroup")
          .orderBy('time')
          .snapshots()
          .listen((event) {
        msg.clear();
        for (QueryDocumentSnapshot querysnapshot in event.docs) {
          debugPrint(jsonEncode(querysnapshot.data()));
          String id = querysnapshot.id;
// msg.add(querysnapshot.data()['']);
          var data = MessageModel.fromRawJson(jsonEncode(querysnapshot.data()));

          msg.add(MessageId(id: id, msg: data));
        }
        msg = msg.reversed.toList();
        emit(FirebasegroupmessagingLoaded(chats: msg));
      });
    } catch (e) {
      if (e is SocketException) {
        debugPrint(e.message);
      }
      if (e is FirebaseException) {
        debugPrint(e.message);
      }
    }
  }

  addMessage(chatMessageData) {
    try {
      Firebaserepo().addMessage(chatMessageData);
      emit(FirebasegroupmessagingAdd());
    } catch (e) {
      if (e is FirebaseException) debugPrint(e.message);
    }
  }

  deleteIt(id) async {
    try {
      var check = await Firebaserepo().deleteMessage(id);
      emit(FirebasegroupmessagingDelte(check: check));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  updateIt(mesg, id) async {
    try {
      var check = await Firebaserepo.updated(mesg, id);
      emit(Firebasegroupmessagingupdate(check: check));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
