import 'package:flutter/widgets.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:milkton_executive/configs/apiSecrets.dart';

final HttpLink httpLink = HttpLink(kGraphQLApiUrl);
ValueNotifier<GraphQLClient> client = ValueNotifier(
  GraphQLClient(
    link: httpLink,
    cache: GraphQLCache(
      store: HiveStore(),
    ),
  ),
);
