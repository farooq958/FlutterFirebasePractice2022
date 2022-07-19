part of 'firebaseotp_cubit.dart';

@immutable
abstract class FirebaseotpState {}

class FirebaseotpInitial extends FirebaseotpState {}

class FirebaseotpLoaded extends FirebaseotpState {}

class FirebaseotpException extends FirebaseotpState {}
class Firebaseotpautofetched extends FirebaseotpState {

  late String otpfetchedauto;
  Firebaseotpautofetched({required otpfetchedauto});

}