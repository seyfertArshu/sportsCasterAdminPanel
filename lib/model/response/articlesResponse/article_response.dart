// To parse this JSON data, do
//
//     final articleResponse = articleResponseFromJson(jsonString);

import 'dart:convert';

List<ArticleResponse> articleResponseFromJson(String str) {
  List<dynamic> jsonList = json.decode(str);
  return jsonList
      .map((jsonObject) => ArticleResponse.fromJson(jsonObject))
      .toList();

  // List < ArticleResponse.fromJson(json.decode(str));
}

String articleResponseToJson(ArticleResponse data) =>
    json.encode(data.toJson());

class ArticleResponse {
  final String auther;
  final String title;
  final String description;
  final String content;
  final String category;
  final bool topTrend;
  final String twitterId;
  final String imageUrl;
  final String websiteUrl;
  final String id;
  final DateTime createdAt;

  ArticleResponse({
    required this.auther,
    required this.title,
    required this.description,
    required this.content,
    required this.category,
    required this.topTrend,
    required this.twitterId,
    required this.imageUrl,
    required this.websiteUrl,
    required this.id,
    required this.createdAt,
  });

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      ArticleResponse(
        auther: json["auther"],
        title: json["title"],
        description: json["description"],
        content: json["content"],
        category: json["category"],
        topTrend: json["topTrend"],
        twitterId: json["twitterId"],
        imageUrl: json["imageUrl"],
        websiteUrl: json["websiteUrl"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "auther": auther,
        "title": title,
        "description": description,
        "content": content,
        "category": category,
        "topTrend": topTrend,
        "twitterId": twitterId,
        "imageUrl": imageUrl,
        "websiteUrl": websiteUrl,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
      };
}
