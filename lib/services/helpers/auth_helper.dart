import 'dart:convert';
import 'dart:developer';

import 'package:agriappadmin/model/login_model.dart';
import 'package:agriappadmin/model/response/auth/login_response.dart';
import 'package:agriappadmin/services/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = http.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.https(Config.apiUrl, Config.loginUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      print("Sucess");
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = loginResponseModelFromJson(response.body).userToken;
      String userId = loginResponseModelFromJson(response.body).id;
      String profile = loginResponseModelFromJson(response.body).profile;

      await prefs.setString('token', token);
      await prefs.setString('userId', userId);
      await prefs.setString('profile', profile);
      await prefs.setBool('loggedIn', true);
      //
      Get.snackbar("Sign in Successful", "Welcome",
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.add_alert));

      return true;
    } else {
      print("failed");
      //  Get.snackbar("Sign Failed", "Check Your Credential",
      //       colorText: Colors.white,
      //       backgroundColor: Colors.red,
      //       icon: const Icon(Icons.add_alert));

      return false;
    }
  }
}
