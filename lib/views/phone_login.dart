import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/cubitss/firebaseotp_cubit.dart';

import 'dashboard_Screen.dart';

class PhoneVerification extends StatefulWidget {
  const PhoneVerification({Key? key}) : super(key: key);

  @override
  State<PhoneVerification> createState() => PhoneVerificationState();
}

class PhoneVerificationState extends State<PhoneVerification> {
  var phoneController = TextEditingController();
  var otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<FirebaseOtpCubit, FirebaseOtpState>(
        listener: (context, state) {
          if (state is FirebaseOtpInitial) {
            var snacks = const SnackBar(
              content: Text('validating Phone number Sending otp '),
            );
            ScaffoldMessenger.of(context).showSnackBar(snacks);
          }
          if (state is FirebaseOtpLoaded) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen(true)));
          }
          if (state is FirebaseOtpAutoFetched) {
            otpController.text = state.otpFetchedAuto;
          }
          if (state is FirebaseotpSentotpcodecheck) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DashboardScreen(true)));
          }
          if (state is FirebaseOtpException) {
            var snacks = SnackBar(
              content: Text(state.msg!),
            );
            ScaffoldMessenger.of(context).showSnackBar(snacks);
          }
        },
        child: ListView(
          children: [
            const SizedBox(
              height: 300,
            ),
            //phone number text form field
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(color: Colors.black)),
                child: TextFormField(
                  controller: phoneController,
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
                    .read<FirebaseOtpCubit>()
                    .fetchOtp("+${phoneController.text}");

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
                  controller: otpController,
                  onChanged: (e) {
                    if (e.length == 6) {
                      context
                          .read<FirebaseOtpCubit>()
                          .verifyOtpManual(otpController);
                    }
                  },
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Your otp received',
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
