import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/cubit/all_orders/all_orders_cubit.dart';
import 'package:milkton_executive/cubit/query/query_cubit.dart';
import 'package:milkton_executive/cubit/search/search_cubit.dart';
import 'package:milkton_executive/cubit/status/status_cubit.dart';
import 'package:milkton_executive/cubit/user/user_cubit.dart';
import 'package:milkton_executive/graphql/query.dart';
import 'package:milkton_executive/models/executive.dart';
import 'package:milkton_executive/models/order.dart';
import 'package:milkton_executive/presentation/widgets/buttons.dart';
import 'package:milkton_executive/presentation/widgets/order_card.dart';
import 'package:milkton_executive/presentation/widgets/top_nav_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key}) : super();

  @override
  Widget build(BuildContext context) {
    final List buttonStates = [
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
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: Colors.deepPurple,
          title: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchActive) {
                return TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    onChanged: (value) {
                      context.read<QueryCubit>().setQuery(value);
                    });
              }
              return const Text("Milkton Executive");
            },
          ),
          actions: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return IconButton(
                    onPressed: () {
                      if (state is SearchActive) {
                        context.read<QueryCubit>().setQuery("");
                        context.read<SearchCubit>().closeSearch();
                      } else {
                        context.read<SearchCubit>().activateSearch();
                      }
                    },
                    icon: Icon(
                        state is SearchActive ? Icons.close : Icons.search));
              },
            ),
            const SizedBox(width: 12),
          ],
        ),
        drawer: const TopNavDrawer(),
        body: Query(
          options: QueryOptions(
            document: gql(appExecutive),
          ),
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
                      style: TextStyle(
                        fontSize: 18,
                      )),
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
                      builder: (context, state) {
                        var filteredOrders = orders
                            .where((order) {
                              if (queryState.isEmpty) {
                                return true;
                              } else {
                                return order['customer']['firstName']
                                        .toString()
                                        .toLowerCase()
                                        .contains(queryState.toLowerCase()) ||
                                    order['customer']['lastName']
                                        .toString()
                                        .toLowerCase()
                                        .contains(queryState.toLowerCase()) ||
                                    order['customer']['phone']
                                        .toString()
                                        .toLowerCase()
                                        .contains(queryState.toLowerCase()) ||
                                    order['customer']['address']
                                        .toString()
                                        .toLowerCase()
                                        .contains(queryState.toLowerCase());
                              }
                            })
                            .where((order) =>
                                context.read<StatusCubit>().state.title == "ALL"
                                    ? true
                                    : context.read<StatusCubit>().state.title ==
                                        order['status'])
                            .toList();
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: buttonStates
                                    .map(
                                      (buttonState) => Row(
                                        children: <Widget>[
                                          SecondaryButton(
                                            isActive: buttonState["title"] ==
                                                context
                                                    .read<StatusCubit>()
                                                    .state
                                                    .title,
                                            title: buttonState["title"],
                                            count: buttonState["title"] == "ALL"
                                                ? orders.length
                                                : orders
                                                    .where((order) =>
                                                        order['status'] ==
                                                        buttonState["title"])
                                                    .length,
                                            onPressed: () {
                                              context
                                                  .read<StatusCubit>()
                                                  .setStatus(
                                                      buttonState["state"]
                                                          as StatusState);
                                            },
                                          ),
                                          const SizedBox(width: 12),
                                        ],
                                      ),
                                    )
                                    .toList(),
                              ),
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
                                      ...filteredOrders
                                          .where((order) => context
                                                      .read<StatusCubit>()
                                                      .state
                                                      .title ==
                                                  "ALL"
                                              ? true
                                              : context
                                                      .read<StatusCubit>()
                                                      .state
                                                      .title ==
                                                  order['status'])
                                          .map(
                                            (order) => Column(
                                              children: [
                                                const SizedBox(height: 12),
                                                OrderCard(
                                                    order:
                                                        Order.fromJson(order)),
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
