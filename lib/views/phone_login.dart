import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/firebaseotp_cubit.dart';

import 'dashboard_Screen.dart';

class Phoneverfication extends StatefulWidget {
  const Phoneverfication({Key? key}) : super(key: key);

  @override
  State<Phoneverfication> createState() => _PhoneverficationState();
}

class _PhoneverficationState extends State<Phoneverfication> {
  var phonecontroller = TextEditingController();
  var otpcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FirebaseotpCubit, FirebaseotpState>(
        listener: (context, state) {
          if (state is FirebaseotpInitial) {
            var snackk = const SnackBar(
              content: Text('validating Phone number Sending otp '),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackk);
          }
          if (state is FirebaseotpLoaded) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen(true)));
          }
          if (state is Firebaseotpautofetched) {
            otpcontroller.text = state.otpfetchedauto;
          }
          if (state is FirebaseotpSentotpcodecheck) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen(true)));
          }
          if (state is FirebaseotpException) {
            var snackk = SnackBar(
              content: Text(state.msg!),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackk);
          }
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 300,
            ),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  controller: phonecontroller,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'enter a valid phone number',
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                context
                    .read<FirebaseotpCubit>()
                    .fetchotp("+${phonecontroller.text}");

                // FirebaseServices().fetchotp("+${phonecontroller.text}");
                //  FirebaseServices().verify(otpcontroller, context);
              },
              color: Colors.red,
              child: const Text('fetch otp '),
            ),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  controller: otpcontroller,
                  onChanged: (e) {
                    if (e.length == 6) {
                      context
                          .read<FirebaseotpCubit>()
                          .verifyotpmanual(otpcontroller);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Your otp recieved',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
