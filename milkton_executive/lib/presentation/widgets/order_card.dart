import 'package:flutter/material.dart';
import 'package:milkton_executive/presentation/widgets/buttons.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Abhibhaw Asthana"),
            subtitle: Text('+91 7754949803'),
            trailing: Text("Subscription"),
          ),
          ListTile(
            leading: Icon(Icons.location_city),
            title: Text("Abhibhaw Asthana"),
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Desi Cow Milk"),
            trailing: Text("2"),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {},
                child: Text("Undelivered"),
              ),
              TextButton(
                onPressed: () {},
                child: Text("Delivered"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
