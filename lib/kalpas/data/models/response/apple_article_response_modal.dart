// To parse this JSON data, do
//
//     final appleArticleResponseModal = appleArticleResponseModalFromJson(jsonString);

import 'dart:convert';

AppleArticleResponseModal appleArticleResponseModalFromJson(String str) =>
    AppleArticleResponseModal.fromJson(json.decode(str));

String appleArticleResponseModalToJson(AppleArticleResponseModal data) =>
    json.encode(data.toJson());

class AppleArticleResponseModal {
  String status;
  int totalResults;
  List<AppleArticle> articles;

  AppleArticleResponseModal({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory AppleArticleResponseModal.fromJson(Map<String, dynamic> json) =>
      AppleArticleResponseModal(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<AppleArticle>.from(
            json["articles"].map((x) => AppleArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class AppleArticle {
  Source source;
  String? author;
  String title;
  String description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;

  AppleArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory AppleArticle.fromJson(Map<String, dynamic> json) => AppleArticle(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  String? id;
  String name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
