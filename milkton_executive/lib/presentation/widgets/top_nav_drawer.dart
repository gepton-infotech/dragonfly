import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/auth/auth_cubit.dart';

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
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.link),
                title: const Text('Developer Info'),
                onTap: () {
                  Navigator.pop(context);
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
              const Text("Milkton v1.0.0"),
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
