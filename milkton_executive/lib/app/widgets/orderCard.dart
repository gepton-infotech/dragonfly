import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkton_executive/constants/color_constant.dart';

class OrderCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String address;
  final List products;

  OrderCard(
      {this.firstName, this.lastName, this.address, this.phone, this.products});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: kDarkBlue)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                '$firstName $lastName'.toUpperCase(),
                style: TextStyle(
                    color: kDarkBlue,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                '$phone',
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              title: Text(
                '$address',
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Get.bottomSheet(
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'EDIT ORDER & DELIVER',
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                        backgroundColor: kWhite);
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kBluish, onPrimary: kWhite),
                  child: Text('EDIT & DELIVER')),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.snackbar('Undeliver', 'Deliver');
                  },
                  style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor, onPrimary: kWhite),
                  child: Text('MARK UNDELIVERED'),
                ),
                ElevatedButton(
                    onPressed: () {
                      Get.snackbar('MARK DELIVERED', 'Hehe');
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text('MARK DELIVERED'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
