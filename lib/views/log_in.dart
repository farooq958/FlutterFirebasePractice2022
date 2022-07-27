import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import 'package:tasky/shared_component/resuablescreen.dart';
import 'package:tasky/views/dashboard_Screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const DashboardScreen(false);
            } else {
              var reus = Reusablescreen();
              return reus.reusablescreens("Log In", context);
            }
          },
        ),
      ),
    );
  }
}
