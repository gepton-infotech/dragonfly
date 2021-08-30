import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:milkton_executive/configs/apiSecrets.dart';

Future<dynamic> checkCredentials(String phone, String password) async {
  return http.post(
    Uri.parse(kExecutiveLoginApiUrl),
    body: {
      "phone": phone,
      "password": password,
    },
  ).then((loginResponse) {
    return json.decode(loginResponse.body);
  }).onError((error, stackTrace) => print(error.toString()));
}
