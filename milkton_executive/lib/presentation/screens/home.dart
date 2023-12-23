import 'package:flutter/material.dart';
import 'package:milkton_executive/presentation/widgets/buttons.dart';
import 'package:milkton_executive/presentation/widgets/order_card.dart';
import 'package:milkton_executive/presentation/widgets/top_nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    final List buttonStates = [
      {
        "title": "All",
        "count": 50,
        "isActive": true,
      },
      {
        "title": "Active",
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

    final List orderList = [
      {
        "customerName": "John Doe",
        "customerPhone": "9876543210",
        "customerAddress": "123, Main Street, Bangalore",
        "status": "DELIVERED",
        "isSub": false,
      },
      {
        "customerName": "John Doe",
        "customerPhone": "9876543210",
        "customerAddress": "123, Main Street, Bangalore",
        "status": "ACTIVE",
        "isSub": true,
      },
      {
        "customerName": "John Doe",
        "customerPhone": "9876543210",
        "customerAddress": "123, Main Street, Bangalore",
        "status": "DELIVERED",
        "isSub": false,
      },
      {
        "customerName": "John Doe",
        "customerPhone": "9876543210",
        "customerAddress": "123, Main Street, Bangalore",
        "status": "ACTIVE",
        "isSub": true,
      },
      {
        "customerName": "John Doe",
        "customerPhone": "9876543210",
        "customerAddress": "123, Main Street, Bangalore",
        "status": "DELIVERED",
        "isSub": false,
      },
      {
        "customerName": "John Doe",
        "customerPhone": "9876543210",
        "customerAddress": "123, Main Street, Bangalore",
        "status": "ACTIVE",
        "isSub": true,
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
                Column(children: <Widget>[
                  ...orderList.map(
                    (order) => Column(
                      children: [
                        const SizedBox(height: 12),
                        OrderCard(
                          customerName: order["customerName"],
                          customerPhone: order["customerPhone"],
                          customerAddress: order["customerAddress"],
                          status: order["status"],
                          isSub: order["isSub"],
                        ),
                      ],
                    ),
                  ),
                ]),
              ],
            ),
          ),
        ));
  }
}
