import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/cubit/item/item_cubit.dart';
import 'package:milkton_executive/cubit/user/user_cubit.dart';
import 'package:milkton_executive/graphql/order_mutation.dart';
import 'package:milkton_executive/models/order.dart';
import 'package:milkton_executive/presentation/widgets/loading.dart';

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
        context.read<ItemCubit>().setItems(order.items);
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
                      child: BlocBuilder<ItemCubit, List<Item>>(
                          bloc: context.read<ItemCubit>(),
                          builder: (context, state) {
                            return Column(
                              children: [
                                ...state.map((item) => ListTile(
                                      leading: const Icon(Icons.shopping_cart),
                                      title: Text(item.name),
                                      subtitle: Text("₹ ${item.price}"),
                                      trailing: SizedBox(
                                        width: 150,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<ItemCubit>()
                                                      .decreaseQuantity(
                                                          item.productID);
                                                },
                                                icon: const Icon(Icons.remove)),
                                            Text(
                                              "${item.quantity}",
                                              style: const TextStyle(
                                                  fontSize: 16.0),
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  context
                                                      .read<ItemCubit>()
                                                      .increaseQuantity(
                                                          item.productID);
                                                },
                                                icon: const Icon(Icons.add)),
                                          ],
                                        ),
                                      ),
                                    )),
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Mutation(
                        options: MutationOptions(
                          document: gql(markOrder),
                          onCompleted: (data) {
                            Navigator.of(context).pop();
                          },
                        ),
                        builder: (
                          RunMutation runMutation,
                          QueryResult? result,
                        ) {
                          if (result!.isLoading) {
                            return const Loading();
                          }
                          return ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor:
                                  WidgetStateProperty.all(Colors.white),
                              backgroundColor:
                                  WidgetStateProperty.all(Colors.green),
                            ),
                            onPressed: () {
                              if (context.read<UserCubit>().state
                                  is UserFound) {
                                final executive = (context
                                        .read<UserCubit>()
                                        .state as UserFound)
                                    .executive;
                                runMutation({
                                  'id': order.id,
                                  'status': 'DELIVERED',
                                  'items': context
                                      .read<ItemCubit>()
                                      .state
                                      .map((e) => {
                                            'productID': e.productID,
                                            'quantity': e.quantity,
                                            'price': e.price,
                                            'name': e.name,
                                            'id': e.id,
                                          })
                                      .toList(),
                                  'comment': order.comment.characters.isNotEmpty
                                      ? '${order.comment} - Delivered from app by ${executive.firstName} ${executive.lastName}'
                                      : 'Delivered from app by ${executive.firstName} ${executive.lastName}'
                                });
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            child: const Text("Deliver"),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            });
      },
      icon: const Icon(Icons.local_shipping_outlined),
      label: const Text('DELIVER'),
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(Colors.white),
        backgroundColor: WidgetStateProperty.all(Colors.green),
      ),
    );
  }
}
