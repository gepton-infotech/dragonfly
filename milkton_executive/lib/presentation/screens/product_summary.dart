import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/all_orders/all_orders_cubit.dart';
import 'package:milkton_executive/presentation/widgets/loading.dart';

class ProductSummaryScreen extends StatelessWidget {
  const ProductSummaryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurpleAccent,
          title: const Text("Product Summary"),
        ),
        body: BlocBuilder<AllOrdersCubit, AllOrdersState>(
          buildWhen: (previous, current) => current is! AllOrdersInitial,
          builder: (context, state) {
            if (state is AllOrdersFound) {
              List uniqueItems = [];

              for (var order in state.orders) {
                String status = order["status"];
                order["items"].forEach((item) {
                  var foundItem = uniqueItems.firstWhere(
                      (element) =>
                          element["productID"] == item["productID"] &&
                          element["status"] == status,
                      orElse: () => {});

                  if (foundItem.isNotEmpty) {
                    foundItem["quantity"] += item["quantity"];
                  } else {
                    item["status"] = status;
                    uniqueItems.add(item);
                  }
                });
              }
              if (uniqueItems.isEmpty) {
                return const Center(
                  child: Text("No orders found"),
                );
              }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ...uniqueItems.map((item) {
                      return ListTile(
                          title: Text(item["name"]),
                          subtitle: Text(
                            item["status"],
                            style: TextStyle(
                              color: item["status"] == "ACTIVE"
                                  ? Colors.purple
                                  : item["status"] == "DELIVERED"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                          trailing: Text(item["quantity"].toString()),
                          leading: const Icon(Icons.shopping_cart_outlined));
                    }),
                  ],
                ),
              );
            } else {
              return const Loading();
            }
          },
        ));
  }
}
