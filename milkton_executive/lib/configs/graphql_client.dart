import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/env.dart';

ValueNotifier<GraphQLClient> getClient(final String token) {
  const serverUrl = GraphqlConfig.graphqlUrl;
  final HttpLink httpLink = HttpLink("$serverUrl/api/");
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer $token',
  );

  final Link link = authLink.concat(httpLink);

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );
  return client;
}
