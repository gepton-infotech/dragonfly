import 'package:flutter/material.dart';
import 'package:milkton_executive/presentation/widgets/buttons.dart';
import 'package:milkton_executive/presentation/widgets/order_card.dart';
import 'package:milkton_executive/presentation/widgets/top_nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();

    final List buttonStates = [
      {
        "title": "All",
        "count": 50,
        "isActive": true,
      },
      {
        "title": "Pending",
        "count": 20,
        "isActive": false,
      },
      {
        "title": "Delivered",
        "count": 25,
        "isActive": false,
      },
      {
        "title": "Undelivered",
        "count": 5,
        "isActive": false,
      },
    ];

    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          title: const Text("Milkton Executive"),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 12),
          ],
        ),
        drawer: const TopNavDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Today: 01 Jan 2024",
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Colors.deepPurpleAccent,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: buttonStates
                        .map(
                          (buttonState) => Row(
                            children: <Widget>[
                              SecondaryButton(
                                isActive: buttonState["isActive"],
                                title: buttonState["title"],
                                count: buttonState["count"],
                              ),
                              const SizedBox(width: 12),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
                const Column(children: <Widget>[
                  SizedBox(height: 12),
                  OrderCard(),
                  OrderCard(),
                  OrderCard(),
                  OrderCard(),
                  OrderCard(),
                  OrderCard(),
                  OrderCard(),
                ]),
              ],
            ),
          ),
        ));
  }
}
