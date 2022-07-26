import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/shared_component/firebase_services.dart';

import 'package:tasky/views/log_in.dart';
import 'package:tasky/views/phone_login.dart';

import '../views/sign_up.dart';

class ReusableScreen {
  //  l for login page controller
  //  s for signup page controller
  var lEmailController = TextEditingController();

  var lPasswordController = TextEditingController();
  var sEmailController = TextEditingController();
  var sPasswordController = TextEditingController();

//Re-usable screen for  login and signup
  Widget reUsableScreen(String titleName, BuildContext context) {
    return SizedBox(
      height: 1.sh,
      width: 1.sw * 3,
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          //main widget
          Stack(
            children: [
              //image takes dynamic width height ..Parent widget
              FittedBox(
                  fit: BoxFit.fitHeight,
                  child: Image.asset(
                    'assest/images/aaaa.png',
                    width: 428,
                    height: 300,
                    fit: BoxFit.fitHeight,
                  )),
              Positioned(
                  right: 100, top: 60, child: ReusableScreen.reUsableText())
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: 1.sw,
              height: 0.55.sh,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              titleName,
                              style: const TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 39.0,
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Expanded(
                              child: SizedBox(
                            width: 102.0,
                            height: 45.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: GestureDetector(
                                      onLongPress: () {
                                        var snackk = const SnackBar(
                                          content: Text(
                                              'Aap soch rahai hongy k ye apple hai lekin ye apple nahi.. kya kre majboori hai .. '),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackk);
                                      },
                                      onTap: () {
                                        FirebaseServices().signInWithGoogle();
                                      },
                                      child: Container(
                                          width: 50.0,
                                          height: 45.0,
                                          margin:
                                              const EdgeInsets.only(right: 20),
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: Colors.red),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Icon(
                                            Icons.apple,
                                            size: 40,
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: InkWell(
                                      onTap: () {
                                        FirebaseServices()
                                            .signInWithFacebook(context);
                                      },
                                      child: Container(
                                          width: 50.0,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                              border:
                                                  Border.all(color: Colors.red),
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                          child: const Icon(
                                            Icons.facebook,
                                            size: 30,
                                          )),
                                    ),
                                  ),
                                ),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: InkWell(
                                    onTap: () {
                                      FirebaseServices().signInWithTwitter();
                                    },
                                    child: Container(
                                        width: 50.0,
                                        height: 45.0,
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.red),
                                            shape: BoxShape.rectangle,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: const Center(
                                            child: Text(' Twitter'))),
                                  ),
                                ))
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                  ),
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Email',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 17.0,
                            color: Color(0xFF888888),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 346.0,
                        height: 73.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white.withOpacity(0.0),
                          border: Border.all(
                            width: 1.0,
                            color: const Color(0xFF707070),
                          ),
                        ),
                        child: TextField(
                          controller: titleName == 'Log In'
                              ? lEmailController
                              : sEmailController,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Expanded(
                    flex: 1,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Password',
                          style: TextStyle(
                            fontFamily: 'Segoe UI',
                            fontSize: 17.0,
                            color: Color(0xFF888888),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: 346.0,
                        height: 73.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white.withOpacity(0.0),
                          border: Border.all(
                            width: 1.0,
                            color: const Color(0xFF707070),
                          ),
                        ),
                        child: TextFormField(
                          controller: titleName == 'Log In'
                              ? lPasswordController
                              : sPasswordController,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      child: SizedBox(
                        height: 100,
                        width: 300,
                        child: MaterialButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PhoneVerification()));
                          },
                          color: Colors.white24,
                          shape: Border.all(color: Colors.red),
                          child: const Text('Login with Phone'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Align(
                      child: InkWell(
                        onTap: () async {
                          if (titleName == "Sign Up") {
                            FirebaseServices.SighnUp(
                                sEmailController, sPasswordController, context);
                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> LogIn() ));
                          }
                          if (titleName == "Log In") {
                            FirebaseServices.SighnIn(
                              lEmailController,
                              lPasswordController,
                              context,
                            );

                            //  Navigator.push(context, MaterialPageRoute(builder: (context)=> DashboardScreen() ));
                          }
                        },
                        child: Container(
                          width: 346.0,
                          height: 73.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            gradient: LinearGradient(
                              begin: Alignment.centerRight,
                              end: Alignment.centerLeft,
                              colors: [
                                const Color(0xFF6B0F1A),
                                const Color(0xFF941148).withOpacity(0.86),
                                const Color(0xFFB91372).withOpacity(0.74)
                              ],
                              stops: const [0.0, 0.689, 1.0],
                            ),
                            border: Border.all(
                              width: 1.0,
                              color: const Color(0xFF990000),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.28),
                                offset: const Offset(0, 0),
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              titleName,
                              style: const TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 19.0,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: FittedBox(
                        child: GestureDetector(
                          onTap: () {
                            if (titleName == "Log In") {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Signup()));
                            } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LogIn()));
                            }
                          },
                          child: Text.rich(
                            TextSpan(
                              style: const TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 17.0,
                                color: Color(0xFF888888),
                              ),
                              children: [
                                TextSpan(
                                  text: titleName == "Log In"
                                      ? 'Don\'t have account yet? '
                                      : 'Already Have Account ',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                TextSpan(
                                  text: titleName == "Log In"
                                      ? 'Sign Up'
                                      : "Log In",
                                  style: const TextStyle(
                                    color: Color(0xFF6B0F1A),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//text for login signup screen
  static Widget reUsableText() {
    return Text(
      'Meet',
      style: TextStyle(
        fontSize: 50.0,
        color: Colors.white,
        shadows: [
          Shadow(
            color: Colors.black.withOpacity(0.16),
            offset: const Offset(0, 3.0),
            blurRadius: 6.0,
          ),
        ],
      ),
    );
  }

//circular avatar on dashboard screen
  static Widget reUsableCircularAvatar(String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(35),
      child: Image.asset(
        imagePath,
        width: 70,
        height: 70,
        alignment: Alignment.center,
      ),
    );
  }
}
