import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/all_orders/all_orders_cubit.dart';

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
                order["items"].forEach((item) {
                  var foundItem = uniqueItems.where(
                      (element) => element["productID"] == item["productID"]);
                  if (foundItem.isNotEmpty) {
                    List<dynamic> foundItemList = foundItem.toList();
                    foundItemList[0]["quantity"] += item["quantity"];
                  } else {
                    uniqueItems.add(item);
                  }
                });
              }
              return Column(
                children: [
                  ...uniqueItems.map((item) {
                    return ListTile(
                      title: Text(item["name"]),
                      subtitle: Text("₹${item["price"].toString()}"),
                      trailing: Text(item["quantity"].toString()),
                    );
                  })
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }
}
