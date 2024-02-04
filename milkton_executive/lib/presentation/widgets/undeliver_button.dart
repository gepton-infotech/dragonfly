import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/cubit/user/user_cubit.dart';
import 'package:milkton_executive/graphql/order_mutation.dart';
import 'package:milkton_executive/models/order.dart';
import 'package:milkton_executive/presentation/widgets/loading.dart';

class UndeliverButton extends StatelessWidget {
  const UndeliverButton({
    super.key,
    required this.order,
  });

  final Order order;

  @override
  Widget build(BuildContext context) {
    return Mutation(
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
        return ElevatedButton.icon(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Undeliver order?'),
                    actions: [
                      OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("NO")),
                      ElevatedButton(
                          onPressed: result.isLoading
                              ? null
                              : () {
                                  if (context.read<UserCubit>().state
                                      is UserFound) {
                                    final executive = (context
                                            .read<UserCubit>()
                                            .state as UserFound)
                                        .executive;
                                    runMutation({
                                      'id': order.id,
                                      'status': 'UNDELIVERED',
                                      'comment': order
                                              .comment.characters.isNotEmpty
                                          ? '${order.comment} - Undelivered from app by ${executive.firstName} ${executive.lastName}'
                                          : 'Undelivered from app by ${executive.firstName} ${executive.lastName}'
                                    });
                                  }
                                },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                          child: const Text("YES")),
                    ],
                  );
                });
          },
          icon: const Icon(Icons.cancel_outlined),
          label: const Text("Undeliver"),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.red),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
        );
      },
    );
  }
}
