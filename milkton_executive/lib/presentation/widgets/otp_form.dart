import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';

const double sizedBoxHeight = 8.0;

class OtpForm extends StatelessWidget {
  OtpForm({super.key});
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset('assets/images/password.svg'),
          const Text(
            'Enter OTP',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          const Text(
            'We have sent an OTP to your registered mobile number.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          TextField(
            controller: _otpController,
            maxLength: 6,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              hintText: 'Enter OTP',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          ElevatedButton(
            onPressed: () {
              if (_otpController.text.length != 6) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid mobile number'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              context.read<AuthCubit>().verifyOtp(_otpController.text);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange, // background color
              foregroundColor: Colors.white, // text color
              elevation: 5, // button's elevation when it's pressed
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'Verify',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          const Center(
            child: Text(
              'Please enter the OTP sent to your registered mobile number.',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black54,
              ),
            ),
          )
        ],
      ),
    );
  }
}
