import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> getClient() {
  final HttpLink httpLink = HttpLink(
    'https://milkton.gepton.in/v2/api/',
  );
  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer Token',
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
