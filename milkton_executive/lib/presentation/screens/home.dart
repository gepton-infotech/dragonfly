import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/cubit/status/status_cubit.dart';
import 'package:milkton_executive/graphql/order_query.dart';
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
          title: const Text("Milkton Executive"),
          actions: const [
            Icon(Icons.search),
            SizedBox(width: 12),
          ],
        ),
        drawer: const TopNavDrawer(),
        body: Query(
          options: QueryOptions(
            document: gql(orderForToday),
            variables: const {
              "id": "60a471050ab24a49adfbea28",
            },
          ),
          builder: (QueryResult result,
              {VoidCallback? refetch, FetchMore? fetchMore}) {
            if (result.hasException) {
              return Text(result.exception.toString());
            }

            if (result.isLoading) {
              return const Text('Loading');
            }

            List? orders = result.data?['executive']["ordersForToday"];

            if (orders == null) {
              return const Text('No repositories');
            }

            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                child: BlocBuilder<StatusCubit, StatusState>(
                  builder: (context, state) {
                    var filteredOrders = orders
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
                                          context.read<StatusCubit>().setStatus(
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
                                    SvgPicture.asset('assets/images/cart.svg'),
                                    const Text("No orders here",
                                        style: TextStyle(fontSize: 18)),
                                  ],
                                ))
                            : Column(
                                children: <Widget>[
                                  ...orders
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
        ));
  }
}
