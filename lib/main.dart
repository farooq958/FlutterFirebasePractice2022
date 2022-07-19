import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasky/views/sign_up.dart';
import 'package:firebase_core/firebase_core.dart';

import 'cubitss/firebaseotp_cubit.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(DevicePreview(

    builder: (context) => const MyApp(), // Wrap your app
  ),);
}




class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(

      designSize: const Size(428, 976),
      minTextAdapt: true,
      splitScreenMode: true,

      useInheritedMediaQuery: true,

      builder: ( context,  child) {

        return MultiBlocProvider(


          providers: [

            BlocProvider<FirebaseotpCubit>(
                create: (BuildContext context) => FirebaseotpCubit())

          ],
          child: MaterialApp(
          title: 'Flutter Demo',
            builder: DevicePreview.appBuilder,
            useInheritedMediaQuery: true,
            debugShowCheckedModeBanner: false,
          home:child,
          ),
        );
        },
    child:  const Signup(),
    );

  }
}


