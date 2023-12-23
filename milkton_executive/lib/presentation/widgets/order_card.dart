import 'package:flutter/material.dart';

Color requiredColor(final String status) {
  return status == 'ACTIVE'
      ? Colors.green
      : status == 'DELIVERED'
          ? Colors.purple
          : Colors.red;
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    required this.customerName,
    required this.customerPhone,
    required this.customerAddress,
    required this.status,
    required this.isSub,
  });
  final String customerName;
  final String customerPhone;
  final String customerAddress;
  final String status;
  final bool isSub;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          ListTile(
              leading: const Icon(Icons.person),
              title: Text(customerName),
              subtitle: Text(customerPhone),
              trailing: Text(isSub ? "Subscription" : "One Time")),
          ListTile(
            leading: const Icon(Icons.location_city),
            title: Text(customerAddress),
            trailing: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                // color:
                border: Border.all(color: requiredColor(status)),
              ),
              child: Text(status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: requiredColor(status),
                  )),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Desi Cow Milk"),
            subtitle: Text("₹ 50"),
            trailing: Text("2",
                style: TextStyle(
                  fontSize: 16.0,
                )),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: [
              OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('UN-DELIVER'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.local_shipping_outlined),
                label: const Text('DELIVER'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
