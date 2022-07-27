part of 'firebasegroupmessaging_cubit.dart';

@immutable
abstract class FirebasegroupmessagingState {}

class FirebasegroupmessagingInitial extends FirebasegroupmessagingState {}
class FirebasegroupmessagingLoaded extends FirebasegroupmessagingState {
  List<messageid> chats;
  FirebasegroupmessagingLoaded( {required this.chats});

}
class FirebasegroupmessagingAdd extends FirebasegroupmessagingState {

  FirebasegroupmessagingAdd();

}
class FirebasegroupmessagingDelte extends FirebasegroupmessagingState {
bool check;
FirebasegroupmessagingDelte({required this.check});



}
class Firebasegroupmessagingupdate extends FirebasegroupmessagingState {

  bool check;
  Firebasegroupmessagingupdate({required this.check});
}
