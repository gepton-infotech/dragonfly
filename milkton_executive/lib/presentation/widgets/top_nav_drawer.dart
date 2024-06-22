import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';
import 'package:milkton_executive/cubit/package_info/package_info_cubit.dart';
import 'package:milkton_executive/cubit/user/user_cubit.dart';
import 'package:milkton_executive/models/executive.dart';
import 'package:milkton_executive/presentation/screens/developer.dart';
import 'package:milkton_executive/presentation/screens/product_summary.dart';
import 'package:milkton_executive/presentation/screens/profile.dart';
import 'package:milkton_executive/utils/data.dart';

class TopNavDrawer extends StatelessWidget {
  const TopNavDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final UserState userState = context.read<UserCubit>().state;
    Executive executive = Executive(
      id: "1",
      firstName: "Gepton",
      lastName: "",
      phone: "9099199104",
      photoURL:
          "https://github.com/GEPTON-INFOTECH/GEPTON-INFOTECH/raw/main/branding/xori.jpeg",
      routeName: "Gepton",
    );
    if (userState is UserFound) {
      executive = userState.executive;
    }

    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                  child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(executive.photoURL),
                  ),
                  Text(
                    "${executive.firstName} ${executive.lastName}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(executive.phone),
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              ListTile(
                leading: const Icon(Icons.shop),
                title: const Text('Product List'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProductSummaryScreen();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const Profile();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Developer Info'),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const DeveloperInfoScreen();
                  }));
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Logout'),
                onTap: () {
                  context.read<AuthCubit>().signOut();
                },
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                'assets/images/gepton.png',
                height: 50,
              ),
              BlocBuilder<PackageInfoCubit, PackageInfoState>(
                buildWhen: (previous, current) =>
                    current is! PackageInfoInitial,
                builder: (context, state) {
                  if (state is PackageInfoFound) {
                    return Text("Milkton v${state.packageInfo.version}");
                  }
                  return const Text("Milkton v5.0.0");
                },
              ),
              Text("$today - ${executive.routeName}"),
              const SizedBox(
                height: 20,
              ),
            ],
          )
        ],
      ),
    );
  }
}
