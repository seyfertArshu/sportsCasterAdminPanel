import 'dart:developer';

import 'package:agriappadmin/model/request/article/article_model.dart';
import 'package:agriappadmin/screen/NBBookmarkScreen.dart';
import 'package:agriappadmin/services/helpers/article_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class CreateArticleProvider extends ChangeNotifier {
  //create article

  createArticlefuc(ArticleModel model) {
    ArticleHelper.createArticle(model).then((response) {
      // log(response);
      if (response) {
        Get.snackbar("Article Added Succesfully", "Checkit out!",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.offAll(() => NBBookmarkScreen());
        });
      } else if (!response) {
        Get.snackbar("Adding Article Failed", "Try Again",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  //EditArticle
  updateArticlefuc(ArticleModel model, String userId) {
    ArticleHelper.updateArticle(model, userId).then((response) {
      // log(response);
      if (response) {
        Get.snackbar("Article Updated Succesfully", "Checkit out!",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
        Future.delayed(const Duration(seconds: 1)).then((value) {
          Get.offAll(() => NBBookmarkScreen());
        });
      } else if (!response) {
        Get.snackbar("Updating article Failed", "Try Again",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }

  //Delete Article
  deleteArticlefuc(String articleId) {
    ArticleHelper.deleteArticle(articleId).then((response) {
      // log(response);
      if (response) {
        Get.snackbar("Article Deleted Succesfully", "Checkit out!",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
        Future.delayed(const Duration(seconds: 2)).then((value) {
          Get.off(() => NBBookmarkScreen());
        });
      } else if (!response) {
        Get.snackbar("Deleting article Failed", "Try Again",
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: const Icon(Icons.add_alert));
      }
    });
  }
}
