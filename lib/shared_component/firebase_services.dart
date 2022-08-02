import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tasky/shared_component/helper.dart';

import 'package:twitter_login/twitter_login.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  static Future SighnIn(emailsignin, paswdsignin, BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailsignin.text.trim(), password: paswdsignin.text.trim());
    } on FirebaseAuthException catch (e) {
      var snackk = SnackBar(
        content: Text(e.message!),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackk);
    }
  }

  static Future SighnUp(emailsinup, paswdsignup, BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailsinup.text.trim(), password: paswdsignup.text.trim());
    } on FirebaseAuthException catch (e) {
      var snackk = SnackBar(
        content: Text(e.message!),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackk);
    }
  }

  static Future Signout() async {
    await FirebaseAuth.instance.signOut();
  }

  static String? getcurrentUseremail() {
    return FirebaseAuth.instance.currentUser!.email;
  }

  signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken);
        await _auth.signInWithCredential(authCredential);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      throw e;
    }
  }

  googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  Future<void> fetchotp(String phonenumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phonenumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          debugPrint('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {
        // this.verrificationId = verificationId;
        HelperFunctions.saveVerificationIdSharedPreference(verificationId);

        //debugPrint(verrificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verify(otpController, BuildContext context) async {
    debugPrint(otpController.text);
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: await HelperFunctions.getUserEmailSharedPreference(),
        smsCode: otpController.text);

    signInWithPhoneAuthCredential(phoneAuthCredential, context);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential, BuildContext context) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      debugPrint(authCredential.user!.phoneNumber.toString());
      if (authCredential.user != null) {
        //Navigator.push(context, MaterialPageRoute(builder: (context) => const DashboardScreen()));
      }
    } on FirebaseAuthException catch (e) {
      // debugPrint(verrificationId);
      debugPrint(e.message);
    }
  }

  Future<void> signInWithFacebook(BuildContext context) async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      await _auth.signInWithCredential(facebookAuthCredential);
    } on FirebaseAuthException catch (e) {
      debugPrint(e.message); //Displaying the error message
    }
  }

  void signInWithTwitter() async {
    // Create a TwitterLogin instance
    final twitterLogin = TwitterLogin(
        apiKey: 'ERRcMFNecswIyar134sfxeG6z',
        apiSecretKey: 'PP8SYd0NpoHHdeQQPRmtoS7sQLyhSia5dSVzsOOYoW09JVnkWK',
        redirectURI: 'tasky-twitter-login://');

    // Trigger the sign-in flow
    await twitterLogin.login().then((value) async {
      final twitterAuthCredential = TwitterAuthProvider.credential(
        accessToken: value.authToken!,
        secret: value.authTokenSecret!,
      );

      await _auth.signInWithCredential(twitterAuthCredential);
    });
  }
}
