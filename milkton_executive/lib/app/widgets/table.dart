import 'package:flutter/material.dart';
import 'package:milkton_executive/constants/color_constant.dart';

class SummaryTable extends StatelessWidget {
  final int toDeliverCount;
  final int deliveredCount;
  final int unDeliveredCount;
  SummaryTable(
      {this.deliveredCount, this.toDeliverCount, this.unDeliveredCount});
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
      textDirection: TextDirection.ltr,
      border: TableBorder.all(width: 1.0, color: kDarkBlue),
      children: [
        TableRow(children: [
          Center(
              child: Text(
            'Total',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            'To Deliver',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            'Delivered',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            'Undelivered',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
        ]),
        TableRow(children: [
          Center(
              child: Text(
            (toDeliverCount + deliveredCount + unDeliveredCount).toString(),
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            toDeliverCount.toString(),
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            deliveredCount.toString(),
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            unDeliveredCount.toString(),
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
        ]),
      ],
    );
  }
}
