part of 'firebaseotp_cubit.dart';

@immutable
abstract class FirebaseOtpState {}

class FirebaseOtpInitial extends FirebaseOtpState {}

class FirebaseOtpLoaded extends FirebaseOtpState {}

class FirebaseOtpException extends FirebaseOtpState {
  String? msg;
  FirebaseOtpException({required msg});
}

class FirebaseOtpAutoFetched extends FirebaseOtpState {
  final String otpFetchedAuto;
  FirebaseOtpAutoFetched({required this.otpFetchedAuto});
}

class FirebaseotpSentotpcodecheck extends FirebaseOtpState {}
