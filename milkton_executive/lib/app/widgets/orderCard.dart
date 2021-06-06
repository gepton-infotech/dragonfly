import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/constants/color_constant.dart';
import 'package:milkton_executive/graphql/addTransaction.dart';
import 'package:milkton_executive/graphql/markOrderMutation.dart';
import 'package:milkton_executive/graphql/productsQuery.dart';
import 'package:milkton_executive/services/url_launcher.dart';

final DateTime _today = new DateTime.now();

class OrderCard extends StatelessWidget {
  final TextEditingController _quantityController = TextEditingController();
  final String customerID;
  final String firstName;
  final String lastName;
  final String phone;
  final String status;
  final String comment;
  final String orderID;
  final bool isSub;
  final String address;
  final List products;
  List allProductsData = [];

  OrderCard(
      {this.customerID,
      this.orderID,
      this.firstName,
      this.lastName,
      this.address,
      this.phone,
      this.products,
      this.comment,
      this.isSub,
      this.status});

  @override
  Widget build(BuildContext context) {
    return Query(
        options: QueryOptions(
          document: gql(allProducts),
        ),
        builder: (QueryResult result,
            {VoidCallback refetch, FetchMore fetchMore}) {
          if (result.isLoading) {
            return Center(child: Text('Loading....'));
          }

          if (result.hasException) {
            return Center(
              child: Text('Please check your Internet Connection'),
            );
          }
          if (result.data["products"] == null) {
            return Center(
              child: Text('No Orders for you'),
            );
          }
          if (result.data["products"] != null) {
            allProductsData = result.data["products"];
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
                        title: Text(allProductsData
                            .firstWhere((product) =>
                                product["id"] ==
                                products[i]["productID"])["name"]
                            .toString()),
                        trailing: Container(
                          padding: EdgeInsets.all(8.0),
                          color: Colors.blue,
                          child: Text(
                            products[i]["quantity"].toString(),
                            style: TextStyle(color: kWhite, fontSize: 16.0),
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
                                          ),
                                          for (int i = 0;
                                              i < products.length;
                                              i++)
                                            ListTile(
                                              title: Text(allProductsData
                                                  .firstWhere((product) =>
                                                      product["id"] ==
                                                      products[i]
                                                          ["productID"])["name"]
                                                  .toString()),
                                              trailing: SizedBox(
                                                width: 100,
                                                child: TextField(
                                                  controller:
                                                      _quantityController,
                                                  onChanged: (quantity) {
                                                    products[i]["quantity"] =
                                                        quantity;
                                                  },
                                                  decoration: InputDecoration(
                                                      labelText: 'Qty'),
                                                  keyboardType:
                                                      TextInputType.number,
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .digitsOnly
                                                  ],
                                                ),
                                              ),
                                            ),
                                          Expanded(child: Container()),
                                          Mutation(
                                              options: MutationOptions(
                                                document: gql(addTransaction),
                                                update: (GraphQLDataProxy
                                                        transCache,
                                                    QueryResult transResult) {
                                                  return transCache;
                                                },
                                                onError: (error) =>
                                                    print(error),
                                                onCompleted:
                                                    (dynamic transResultData) {
                                                  print(transResultData);
                                                },
                                              ),
                                              builder:
                                                  (RunMutation addTransaction,
                                                      QueryResult transResult) {
                                                return Mutation(
                                                    options: MutationOptions(
                                                      document: gql(markOrder),
                                                      update: (GraphQLDataProxy
                                                              cache,
                                                          QueryResult result) {
                                                        return cache;
                                                      },
                                                      onError: (error) =>
                                                          print(error),
                                                      onCompleted:
                                                          (dynamic resultData) {
                                                        print(resultData);
                                                      },
                                                    ),
                                                    builder: (RunMutation
                                                            markOrder,
                                                        QueryResult result) {
                                                      return ElevatedButton(
                                                        onPressed: () {
                                                          markOrder({
                                                            'id': orderID,
                                                            'status':
                                                                'DELIVERED',
                                                            'items': products,
                                                          });
                                                          addTransaction({
                                                            'customerID':
                                                                customerID,
                                                            'orderID': orderID,
                                                            'date': new DateTime
                                                                .now(),
                                                            'subTotal': 100
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    kDarkBlue),
                                                        child: Text(
                                                            'MARK DELIVERED'),
                                                      );
                                                    });
                                              })
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
                              Mutation(
                                  options: MutationOptions(
                                    document: gql(markOrder),
                                    update: (GraphQLDataProxy cache,
                                        QueryResult result) {
                                      return cache;
                                    },
                                    onError: (error) => print(error),
                                    onCompleted: (dynamic resultData) {
                                      print(resultData);
                                    },
                                  ),
                                  builder: (RunMutation markOrder,
                                      QueryResult result) {
                                    return ElevatedButton(
                                      onPressed: () => markOrder({
                                        'id': orderID,
                                        'status': 'UNDELIVERED'
                                      }),
                                      style: ElevatedButton.styleFrom(
                                          primary: kPrimaryColor,
                                          onPrimary: kWhite),
                                      child: Text('MARK UNDELIVERED'),
                                    );
                                  }),
                              Mutation(
                                  options: MutationOptions(
                                    document: gql(markOrder),
                                    update: (GraphQLDataProxy cache,
                                        QueryResult result) {
                                      return cache;
                                    },
                                    onError: (error) => print(error),
                                    onCompleted: (dynamic resultData) {
                                      print(resultData);
                                    },
                                  ),
                                  builder: (RunMutation markOrder,
                                      QueryResult result) {
                                    return ElevatedButton(
                                      onPressed: () => markOrder({
                                        'id': orderID,
                                        'status': 'DELIVERED'
                                      }),
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.green),
                                      child: Text('MARK DELIVERED'),
                                    );
                                  })
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
            );
          }
          return Text('Just a moment...');
        });
  }
}
