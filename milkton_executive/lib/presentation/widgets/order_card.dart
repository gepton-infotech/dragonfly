import 'package:flutter/material.dart';
import 'package:milkton_executive/models/order.dart';

Color requiredColor(final String status) {
  return status == 'ACTIVE'
      ? Colors.green
      : status == 'DELIVERED'
          ? Colors.purple
          : Colors.red;
}

class OrderCard extends StatelessWidget {
  final Order order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title:
                Text('${order.customer.firstName} ${order.customer.lastName}'),
            subtitle: Text(order.customer.phone),
            trailing: Text(order.isSub ? "Subscription" : "One Time"),
          ),
          ListTile(
            leading: const Icon(Icons.location_city),
            title: Text(order.customer.address),
            trailing: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: requiredColor(order.status)),
              ),
              child: Text(order.status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: requiredColor(order.status),
                  )),
            ),
          ),
          ...order.items.map((item) => ListTile(
                leading: const Icon(Icons.shopping_cart),
                title: Text(item.name),
                subtitle: Text("₹ ${item.price}"),
                trailing: Text("${item.quantity}",
                    style: const TextStyle(
                      fontSize: 16.0,
                    )),
              )),
          ButtonBar(
            alignment: MainAxisAlignment.spaceBetween,
            children: order.status == "ACTIVE"
                ? [
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.cancel_outlined),
                      label: const Text('UN-DELIVER'),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.local_shipping_outlined),
                      label: const Text('DELIVER'),
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green),
                      ),
                    ),
                  ]
                : [],
          ),
        ],
      ),
    );
  }
}
