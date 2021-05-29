import 'package:flutter/material.dart';
import 'package:milkton_executive/configs/date.dart';
import 'package:milkton_executive/constants/color_constant.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                padding: EdgeInsets.symmetric(vertical: 10.0),
                alignment: Alignment.center,
                color: kRaisinBlack,
                child: Text(
                  'Today: ' + today,
                  style: TextStyle(fontSize: 18.0, color: kWhite),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  'Summary',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
              Container(
                child: SummaryTable(),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Column(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Text('Name: Abhibhaw Asthana'),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

class SummaryTable extends StatelessWidget {
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
            '4',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            '5',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            '6',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
          Center(
              child: Text(
            '4',
            style: TextStyle(
              fontSize: 16.0,
            ),
          )),
        ]),
      ],
    );
  }
}
