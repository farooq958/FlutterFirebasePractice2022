import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'firebaseotp_state.dart';

class FirebaseotpCubit extends Cubit<FirebaseotpState> {
  FirebaseotpCubit() : super(FirebaseotpInitial());
  final _auth = FirebaseAuth.instance;
 late String otpfetchedauto;
fetchotp( String phonenumber)

async {
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
        emit(FirebaseotpException());
      }
    },

    codeSent: (String verificationId, int? resendToken) async {


      // this.verrificationId = verificationId;


      debugPrint('code send ');

    },

    codeAutoRetrievalTimeout: (String verificationId) {
    },
  );


}


}
