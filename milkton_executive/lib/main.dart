import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/configs/graphql_client.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';
import 'package:milkton_executive/cubit/status/status_cubit.dart';
import 'package:milkton_executive/firebase_options.dart';
import 'package:milkton_executive/presentation/screens/home.dart';
import 'package:milkton_executive/presentation/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initHiveForFlutter();
  runApp(const MilktonExecutive());
}

class MilktonExecutive extends StatelessWidget {
  const MilktonExecutive({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
        BlocProvider<StatusCubit>(create: (context) => StatusCubit()),
      ],
      child: MaterialApp(
        title: 'Milkton Executive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => current is! AuthInitial,
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return GraphQLProvider(
                client: getClient(),
                child: const HomeScreen(),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
