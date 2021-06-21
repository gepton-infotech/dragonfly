import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/graphql/productsQuery.dart';

class ProductList extends StatelessWidget {
  final List productList;
  List allProductsData = [];
  ProductList({this.productList});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product List'),
      ),
      body: Query(
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
              return ListView.builder(
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(allProductsData
                          .firstWhere((product) =>
                              product["id"] ==
                              productList[index]["productID"])["name"]
                          .toString()),
                      subtitle: Text(productList[index]["status"].toString()),
                      trailing: Text(productList[index]["quantity"].toString()),
                    );
                  });
            }
            return Text('Something went wrong');
          }),
    );
  }
}
