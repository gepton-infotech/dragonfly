import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';
import 'package:milkton_executive/firebase_options.dart';
import 'package:milkton_executive/presentation/screens/home.dart';
import 'package:milkton_executive/presentation/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MilktonExecutive());
}

class MilktonExecutive extends StatelessWidget {
  const MilktonExecutive({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        title: 'Milkton Executive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          primarySwatch: Colors.deepOrange,
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => current is! AuthInitial,
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return const HomeScreen(
                title: "Milkton Executive",
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
