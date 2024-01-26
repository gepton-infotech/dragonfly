import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

ValueNotifier<GraphQLClient> getClient(
    final String serverURL, final String token) {
  final HttpLink httpLink = HttpLink("${serverURL}api/");
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
