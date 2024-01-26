import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/cubit/all_orders/all_orders_cubit.dart';
import 'package:milkton_executive/cubit/query/query_cubit.dart';
import 'package:milkton_executive/cubit/status/status_cubit.dart';
import 'package:milkton_executive/cubit/user/user_cubit.dart';
import 'package:milkton_executive/graphql/query.dart';
import 'package:milkton_executive/models/executive.dart';
import 'package:milkton_executive/models/order.dart';
import 'package:milkton_executive/presentation/widgets/home_app_bar.dart';
import 'package:milkton_executive/presentation/widgets/order_card.dart';
import 'package:milkton_executive/presentation/widgets/status_buttons.dart';
import 'package:milkton_executive/presentation/widgets/top_nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar,
        drawer: const TopNavDrawer(),
        body: Query(
          options: QueryOptions(document: gql(appExecutive)),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }
            if (result.isLoading) {
              return const Text('Loading');
            }
            final data = result.data?['appExecutive'];

            if (data == null) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/images/working.svg'),
                  const Text("Oops! you don't belong here",
                      style: TextStyle(fontSize: 18)),
                ],
              );
            }

            final executive = Executive(
              id: data["id"],
              firstName: data["firstName"],
              lastName: data["lastName"],
              phone: data["phone"],
              photoURL: data["photoURL"],
              routeName: data["route"]["routeName"],
            );

            context.read<UserCubit>().updateUser(executive);

            List? orders = data["ordersForToday"];

            if (orders == null) {
              return const Text('No Orders Found');
            }
            context.read<AllOrdersCubit>().getOrders(orders);

            return BlocBuilder<QueryCubit, String>(
              builder: (context, queryState) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: BlocBuilder<StatusCubit, StatusState>(
                      builder: (context, statusState) {
                        var filteredOrders = _filterOrders(
                            orders, queryState, statusState.title);
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            StatusButtons(
                              orders: orders,
                              statusStateText: statusState.title,
                            ),
                            filteredOrders.isEmpty
                                ? Padding(
                                    padding: const EdgeInsets.all(36.0),
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                            'assets/images/cart.svg'),
                                        const Text("No orders here",
                                            style: TextStyle(fontSize: 18)),
                                      ],
                                    ))
                                : Column(
                                    children: <Widget>[
                                      ...filteredOrders.map(
                                        (order) => Column(
                                          children: [
                                            const SizedBox(height: 12),
                                            OrderCard(
                                                order: Order.fromJson(order)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}

List _filterOrders(List orders, String query, String status) {
  return orders
      .where((order) {
        if (query.isEmpty) {
          return true;
        } else {
          return order['customer']['firstName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              order['customer']['lastName']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              order['customer']['phone']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()) ||
              order['customer']['address']
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase());
        }
      })
      .where((order) => status == "ALL" ? true : status == order['status'])
      .toList();
}
