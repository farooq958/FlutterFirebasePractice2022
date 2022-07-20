import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'firebaseotp_state.dart';

class FirebaseotpCubit extends Cubit<FirebaseotpState> {
  FirebaseotpCubit() : super(FirebaseotpInitial());
  final _auth = FirebaseAuth.instance;
  late String otpfetchedauto;

  late String verrificationId;

  fetchotp(String phonenumber) async {
    emit(FirebaseotpInitial());
    await _auth.verifyPhoneNumber(
      phoneNumber: phonenumber,

      verificationCompleted: (PhoneAuthCredential credential) async {
        otpfetchedauto = credential.smsCode.toString();
        debugPrint(otpfetchedauto);
        emit(Firebaseotpautofetched(otpfetchedauto: otpfetchedauto));
        await _auth.signInWithCredential(credential);
        emit(FirebaseotpLoaded());
      },

      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          debugPrint('The provided phone number is not valid.');
          emit(FirebaseotpException(msg: e.message));
        }
      },

      codeSent: (String verificationId, int? resendToken) async {
        verrificationId = verificationId;


        debugPrint('code send ');
      },

      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyotpmanual(otpcontroller) async
  {
    try {
      var credential = PhoneAuthProvider.credential(
          verificationId: verrificationId, smsCode: otpcontroller.text);
      await _auth.signInWithCredential(credential);
      emit(FirebaseotpSentotpcodecheck());
    }


  catch (e)
  {
  if(e is SocketException)
  {
    emit(FirebaseotpException(msg: e.message));
  }
  if (e is FirebaseAuthException)
    {
      emit(FirebaseotpException(msg: e.message));

    }

  }
}
}
