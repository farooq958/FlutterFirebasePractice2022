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

getchatmessages()
{List<messageid> msg=[] ;
String id ='';
try{
  emit(FirebasegroupmessagingInitial());
  FirebaseFirestore.instance
      .collection("UserGroup")
      .orderBy('time').snapshots().listen((event) {
msg.clear();
    for(QueryDocumentSnapshot querysnapshot in event.docs)
    {
      debugPrint( jsonEncode( querysnapshot.data()));
String id= querysnapshot.id;
// msg.add(querysnapshot.data()['']);
      var data = Messagemodel.fromRawJson(jsonEncode( querysnapshot.data()));

      msg.add(messageid(Id: id, msg: data));
    }
    msg=msg.reversed.toList();
emit(FirebasegroupmessagingLoaded(chats: msg));
  });




}
 catch(e)
{
  if (e is SocketException)
    {
      debugPrint(e.message);
    }
  if (e is FirebaseException)
    {

      debugPrint(e.message);

    }

}

}

admessage(chatMessageData)
{
try{
   Firebaserepo().Addmessage(chatMessageData);
  emit(FirebasegroupmessagingAdd());

}
catch(e)
  {
    if(e is FirebaseException)
    debugPrint(e.message);
  }

}
delteit(id)
async {

  try{
    var check= await Firebaserepo().DelteMessage(id);
    emit(FirebasegroupmessagingDelte(check:check));
  }
  catch(e)
  {
    debugPrint(e.toString());
  }


}
updateit(mesg,id)
async
{
  try{
    var check= await Firebaserepo.updated(mesg, id);
    emit(Firebasegroupmessagingupdate(check:check));
  }
  catch(e)
  {
    debugPrint(e.toString());
  }


}
}
