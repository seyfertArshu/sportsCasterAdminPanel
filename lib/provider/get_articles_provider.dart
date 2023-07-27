import 'package:agriappadmin/model/response/articlesResponse/article_response.dart';
import 'package:agriappadmin/services/helpers/article_helper.dart';
import 'package:flutter/material.dart';

class getArticleProvider extends ChangeNotifier {
  late Future<List<ArticleResponse>> articleList;

  getArticles() {
    articleList = ArticleHelper.getArticles();
  }
}
