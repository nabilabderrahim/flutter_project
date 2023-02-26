import 'package:thingsboard_client/thingsboard_client.dart';
import 'package:flutter/material.dart';

import 'package:version1/page/login.dart';

String tokens_admin = '';
String idCustomer = '';
const thingsBoardApiEndpoint = 'http://91.134.146.229:19999';

class Getjwt_admin {
  String token = '';

  Future<void> login() async {
    try {
      // Create instance of ThingsBoard API Client
      var tbClient = ThingsboardClient(thingsBoardApiEndpoint);

      // Perform login with default Tenant Administrator credentials
      await tbClient
          .login(LoginRequest("tenant@thingsboard.org", "tenant2021"));
      print("jareb" + tbClient.getAuthUser().toString());
      print('isAuthenticated=${tbClient.isAuthenticated()}');

      token = tbClient.getJwtToken().toString();
      print(tbClient.getJwtToken());

      // Finally perform logout to clear credentials
      //await tbClient.logout();
    } catch (e, s) {
      print('Error: $e');
      print('Stack: $s');
    }
  }
}

Future<void> gettoken_admin() async {
  Getjwt_admin instance = Getjwt_admin();
  // print('chenhy1');
  //print(instance);
  await instance.login();
  //print("token  " + instance.token);
  print('holla');

  tokens_admin = "Bearer " + instance.token.toString();
  print('kamalna');
}
