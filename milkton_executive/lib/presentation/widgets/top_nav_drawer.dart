import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';
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
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.75,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const DrawerHeader(
                  child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/xori.jpeg'),
                  ),
                  Text(
                    "Abhibhaw Asthana",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text("+917754949803"),
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
              const Text("Milkton v5.0.0"),
              Text(today),
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
