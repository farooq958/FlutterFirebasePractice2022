import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'firebaseotp_state.dart';

class FirebaseOtpCubit extends Cubit<FirebaseOtpState> {
  FirebaseOtpCubit() : super(FirebaseOtpInitial());
  final _auth = FirebaseAuth.instance;
  late String otpFetchedAuto;

  late String verificationIdCheck;

  fetchOtp(String phoneNumber) async {
    emit(FirebaseOtpInitial());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        otpFetchedAuto = credential.smsCode.toString();
        debugPrint(otpFetchedAuto);
        emit(FirebaseOtpAutoFetched(otpFetchedAuto: otpFetchedAuto));
        await _auth.signInWithCredential(credential);
        emit(FirebaseOtpLoaded());
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          debugPrint('The provided phone number is not valid.');
          emit(FirebaseOtpException(msg: e.message));
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        verificationIdCheck = verificationId;

        debugPrint('code send ');
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyOtpManual(otpController) async {
    try {
      var credential = PhoneAuthProvider.credential(
          verificationId: verificationIdCheck, smsCode: otpController.text);
      await _auth.signInWithCredential(credential);
      emit(FirebaseotpSentotpcodecheck());
    } catch (e) {
      if (e is SocketException) {
        emit(FirebaseOtpException(msg: e.message));
      }
      if (e is FirebaseAuthException) {
        emit(FirebaseOtpException(msg: e.message));
      }
    }
  }
}
