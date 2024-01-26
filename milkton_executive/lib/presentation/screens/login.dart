import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';
import 'package:milkton_executive/presentation/widgets/loading.dart';
import 'package:milkton_executive/presentation/widgets/login_form.dart';
import 'package:milkton_executive/presentation/widgets/otp_form.dart';

// Define constants
const double paddingValue = 12.0;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingValue),
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState) {
                return const Loading();
              }
              if (state is AuthCodeSentState) {
                return OtpForm();
              }
              return LoginForm();
            },
          ),
        ),
      ),
    );
  }
}
