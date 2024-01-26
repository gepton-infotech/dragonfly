import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/configs/graphql_client.dart';
import 'package:milkton_executive/cubit/all_orders/all_orders_cubit.dart';
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
        BlocProvider<AllOrdersCubit>(create: (context) => AllOrdersCubit()),
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
              return FutureBuilder<String?>(
                future: state.idToken,
                builder:
                    (BuildContext context, AsyncSnapshot<String?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }

                    String? idToken = snapshot.data;
                    if (idToken != null) {
                      return GraphQLProvider(
                        client: getClient(
                          "https://milkton.gepton.in/v2/api/",
                          idToken, // Use the ID token here
                        ),
                        child: const HomeScreen(),
                      );
                    } else {
                      return const Text('Error: Unable to get ID token');
                    }
                  }

                  return const CircularProgressIndicator();
                },
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
