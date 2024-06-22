import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/configs/graphql_client.dart';
import 'package:milkton_executive/cubit/all_orders/all_orders_cubit.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';
import 'package:milkton_executive/cubit/item/item_cubit.dart';
import 'package:milkton_executive/cubit/query/query_cubit.dart';
import 'package:milkton_executive/cubit/search/search_cubit.dart';
import 'package:milkton_executive/cubit/status/status_cubit.dart';
import 'package:milkton_executive/cubit/user/user_cubit.dart';
import 'package:milkton_executive/env.dart';
import 'package:milkton_executive/presentation/screens/home.dart';
import 'package:milkton_executive/presentation/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: SupabaseConfig.supabaseUrl,
    anonKey: SupabaseConfig.supabaseAnonKey,
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
        BlocProvider<UserCubit>(create: (context) => UserCubit()),
        BlocProvider<AllOrdersCubit>(create: (context) => AllOrdersCubit()),
        BlocProvider<SearchCubit>(create: (context) => SearchCubit()),
        BlocProvider<QueryCubit>(create: (context) => QueryCubit()),
        BlocProvider<ItemCubit>(create: (context) => ItemCubit()),
      ],
      child: MaterialApp(
        title: 'Milkton Executive',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(),
          primarySwatch: Colors.deepPurple,
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthStates>(
          buildWhen: (previous, current) => current is! AuthInitial,
          builder: (context, state) {
            if (state is AuthLoggedInState) {
              return GraphQLProvider(
                client: getClient(
                  'TODO: token goes here', // Use the ID token here
                ),
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
