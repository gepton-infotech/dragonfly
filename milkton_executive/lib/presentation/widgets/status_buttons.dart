import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milkton_executive/cubit/status/status_cubit.dart';
import 'package:milkton_executive/presentation/widgets/buttons.dart';

final List _buttonStates = [
  {
    "title": "ALL",
    "state": StatusAll(),
  },
  {
    "title": "ACTIVE",
    "state": StatusActive(),
  },
  {
    "title": "DELIVERED",
    "state": StatusDelivered(),
  },
  {
    "title": "UNDELIVERED",
    "state": StatusUndelivered(),
  },
];

class StatusButtons extends StatelessWidget {
  const StatusButtons({
    super.key,
    required this.orders,
    required this.statusStateText,
  });

  final List orders;
  final String statusStateText;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _buttonStates
            .map(
              (buttonState) => Row(
                children: <Widget>[
                  SecondaryButton(
                    isActive: buttonState["title"] == statusStateText,
                    title: buttonState["title"],
                    count: buttonState["title"] == "ALL"
                        ? orders.length
                        : orders
                            .where((order) =>
                                order['status'] == buttonState["title"])
                            .length,
                    onPressed: () {
                      context
                          .read<StatusCubit>()
                          .setStatus(buttonState["state"] as StatusState);
                    },
                  ),
                  const SizedBox(width: 12),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
