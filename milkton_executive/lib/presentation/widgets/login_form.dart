import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';

const double sizedBoxHeight = 8.0;

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SvgPicture.asset('assets/images/scooter.svg'),
          const Text(
            'Login Here',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          const Text(
            'Ready to hit the road and deliver smiles?',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          TextField(
            maxLength: 10,
            keyboardType: TextInputType.phone,
            controller: _phoneNumberController,
            decoration: const InputDecoration(
              hintText: '10 digit mobile number',
              prefixIcon: Icon(Icons.phone),
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          ElevatedButton(
            onPressed: () {
              if (_phoneNumberController.text.length != 10) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a valid mobile number'),
                    backgroundColor: Colors.red,
                  ),
                );
                return;
              }
              context
                  .read<AuthCubit>()
                  .verifyPhoneNumber(_phoneNumberController.text);
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
              'Login',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: sizedBoxHeight),
          const Center(
            child: Text(
              'Please login with your registered mobile number.',
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
