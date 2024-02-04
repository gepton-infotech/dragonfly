import 'package:flutter/material.dart';
import 'package:milkton_executive/models/order.dart';

class DeliverButton extends StatelessWidget {
  const DeliverButton({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        showBottomSheet(
            constraints: const BoxConstraints(
              minWidth: double.infinity,
            ),
            context: context,
            builder: (BuildContext context) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          child: Text(
                            "Review order",
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const Divider(),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          ...order.items.map((item) => ListTile(
                                leading: const Icon(Icons.shopping_cart),
                                title: Text(item.name),
                                subtitle: Text("₹ ${item.price}"),
                                trailing: Text("${item.quantity}",
                                    style: const TextStyle(fontSize: 16.0)),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          onPressed: () {
                            //TODO: Call delivered mutation here
                          },
                          child: const Text('Deliver')),
                    )
                  ],
                ),
              );
            });
      },
      icon: const Icon(Icons.local_shipping_outlined),
      label: const Text('DELIVER'),
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
        backgroundColor: MaterialStateProperty.all(Colors.green),
      ),
    );
  }
}
