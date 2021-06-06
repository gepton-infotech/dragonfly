import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milkton_executive/constants/color_constant.dart';
import 'package:milkton_executive/services/url_launcher.dart';

class OrderCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String status;
  final String comment;
  final bool isSub;
  final String address;
  final List products;

  OrderCard(
      {this.firstName,
      this.lastName,
      this.address,
      this.phone,
      this.products,
      this.comment,
      this.isSub,
      this.status});

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
              trailing: isSub ? Text('Subscription') : Text('One Time'),
              onTap: () {
                launchURL('tel:+91' + phone);
              },
            ),
            ListTile(
              leading: Icon(Icons.location_city),
              trailing: Container(
                padding: EdgeInsets.all(8.0),
                color: status == 'ACTIVE' ? Colors.green : Colors.red,
                child: Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kWhite,
                  ),
                ),
              ),
              title: Text(
                '$address',
              ),
            ),
            for (int i = 0; i < products.length; i++)
              ListTile(
                leading: Icon(Icons.shopping_bag),
                title: Text(products[i]["productID"].toString()),
                trailing: ClipOval(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    color: Colors.blue,
                    child: Text(
                      products[i]["quantity"].toString(),
                      style: TextStyle(color: kWhite, fontSize: 16.0),
                    ),
                  ),
                ),
              ),
            status == 'ACTIVE'
                ? Container(
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
                  )
                : Container(),
            status == 'ACTIVE'
                ? Row(
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
                          style:
                              ElevatedButton.styleFrom(primary: Colors.green),
                          child: Text('MARK DELIVERED'))
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
