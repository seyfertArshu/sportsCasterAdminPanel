// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ArticleModel articleModelFromJson(String str) =>
    ArticleModel.fromJson(json.decode(str));

String articleModelToJson(ArticleModel data) => json.encode(data.toJson());

class ArticleModel {
  final String auther;
  final String title;
  final String description;
  final String content;
  final String category;
  final String twitterId;
  final String imageUrl;
  final String websiteUrl;

  final bool topTrend;

  ArticleModel({
    required this.auther,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.twitterId,
    required this.imageUrl,
    required this.websiteUrl,
    required this.topTrend,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        auther: json["auther"],
        title: json["title"],
        description: json["description"],
        content: json["content"],
        category: json["category"],
        twitterId: json["twitterId"],
        topTrend: json["topTrend"],
        imageUrl: json["imageUrl"],
        websiteUrl: json["websiteUrl"],
      );

  Map<String, dynamic> toJson() => {
        "auther": auther,
        "title": title,
        "description": description,
        "content": content,
        "category": category,
        "twitterId": twitterId,
        "topTrend": topTrend,
        "imageUrl": imageUrl,
        "websiteUrl": websiteUrl,
      };
}
