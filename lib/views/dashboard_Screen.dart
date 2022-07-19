import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/shared_component/firebase_services.dart';
import 'package:tasky/shared_component/resuablescreen.dart';

class DashboardScreen extends StatefulWidget {

  final bool check;
  const DashboardScreen(this.check, {Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState(check);
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final bool check;
_DashboardScreenState(this.check);

  List<String> images = [
    'assest/images/1.png',
    'assest/images/2.png',
    'assest/images/2.png',
    'assest/images/1.png',
    'assest/images/1.png',
    'assest/images/2.png',
    'assest/images/2.png'
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
//key: _key,
        backgroundColor: Colors.white,
        drawer: const Drawer(),
        body: Stack(
          children: [
            Positioned(
              top: -160,
              child: Image.asset(
                'assest/images/Group 17.png',
                width: 1.sw,
                height: 400,
                fit: BoxFit.fitHeight,
              ),
            ),
            Positioned(left: 0.38.sw, child: Reusablescreen.reusabletext()),
            Positioned(
                left: 20,
                top: 20,
                child: Builder(builder: (context) {
                  return InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Image.asset(
                        'assest/images/Icon feather-menu.png',
                        height: 27,
                        width: 18,
                      ));
                })),
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 25.sp),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                SizedBox(
                  height: 140.sp,
                ),
                Container(
                  height: 52,
                  width: 390,
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff6B0F1B)),
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Icon(
                        Icons.search,
                        color: const Color(0xff6B0F1B),
                        size: 40.sp,
                      )),
                      Expanded(
                          flex: 1,
                          child: Text(
                            'Search',
                            style: TextStyle(
                              fontFamily: 'Segoe UI',
                              fontSize: 14.0,
                              color: const Color(0xFF6B0F1B).withOpacity(0.6),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          )),
                      const Expanded(
                          flex: 3,
                          child: Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 15),
                                child: Icon(Icons.filter),
                              )))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                SizedBox(
                  height: 70,
                  child: ListView.builder(
                    itemCount: images.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Reusablescreen
                          .reusablecircularavatar(images[index]);
                    },
                  ),
                ),
                Center(
                    child:check==false? Text(" Logged in as ${FirebaseServices.getcurrentUseremail()}"):Text(" Logged in as ${FirebaseAuth.instance.currentUser!.phoneNumber}")),
                MaterialButton(onPressed: () async {

                 // FirebaseServices.Signout();
                  FirebaseServices().googleSignOut();

                } , color: Colors.red,child: const Text("Signout"),)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
