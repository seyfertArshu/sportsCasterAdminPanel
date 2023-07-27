import 'dart:convert';
import 'dart:developer';

import 'package:agriappadmin/model/login_model.dart';
import 'package:agriappadmin/model/request/article/article_model.dart';
import 'package:agriappadmin/model/response/articlesResponse/article_response.dart';
import 'package:agriappadmin/model/response/auth/login_response.dart';
import 'package:agriappadmin/services/config.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ArticleHelper {
  static var client = http.Client();

  //create
  static Future<bool> createArticle(ArticleModel model) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, Config.createArticleUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 201) {
      print("article added Sucessfully");
      print(response.body);

      // Get.snackbar("New Article Added", "Check it out!",
      //     colorText: Colors.white,
      //     backgroundColor: Colors.red,
      //     icon: const Icon(Icons.add_alert));

      return true;
    } else {
      print("article added failed222");
      print(response.body);

      //  Get.snackbar("Sign Failed", "Check Your Credential",
      //       colorText: Colors.white,
      //       backgroundColor: Colors.red,
      //       icon: const Icon(Icons.add_alert));

      return false;
    }
  }

  //update
  static Future<bool> updateArticle(ArticleModel model, String userId) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'token': 'Bearer $token'
    };
    var url = Uri.https(Config.apiUrl, "${Config.updateArticleUrl}/$userId");
    var response =
        await client.put(url, headers: requestHeaders, body: jsonEncode(model));

    if (response.statusCode == 200) {
      print("Sucess");
      // Get.snackbar("Article Updated", "Check it out!",
      //     colorText: Colors.white,
      //     backgroundColor: Colors.red,
      //     icon: const Icon(Icons.add_alert));

      return true;
    } else {
      print("failed");
      print(response.body);
      //  Get.snackbar("Sign Failed", "Check Your Credential",
      //       colorText: Colors.white,
      //       backgroundColor: Colors.red,
      //       icon: const Icon(Icons.add_alert));

      return false;
    }
  }

  //getArticles
  static Future<List<ArticleResponse>> getArticles() async {
    // final SharedPreferences pref = await SharedPreferences.getInstance();
    //String? token = pref.getString('token');

    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.https(Config.apiUrl, Config.getAllArticleUrl);
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      print("Article response is loaded");
      var articleList = articleResponseFromJson(response.body);
      // Get.snackbar("New Article Added", "Check it out!",
      //     colorText: Colors.white,
      //     backgroundColor: Colors.red,
      //     icon: const Icon(Icons.add_alert));

      return articleList;
    } else {
      throw Exception("Failed to get the articles");
    }
  }
}
