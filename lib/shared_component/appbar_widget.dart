import 'package:flutter/material.dart';

//re usable app bar across the application
class AppBarContainer extends StatelessWidget {
  final String appBarTitle;
  const AppBarContainer({Key? key, required this.appBarTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.lightGreen,
              Colors.indigo,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Center(
              child: Text(appBarTitle,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white70,
                      fontWeight: FontWeight.bold))),
        ));
  }
}
