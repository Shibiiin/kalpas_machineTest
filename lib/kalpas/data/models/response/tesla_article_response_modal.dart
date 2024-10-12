// To parse this JSON data, do
//
//     final teslaArticleResponseModal = teslaArticleResponseModalFromJson(jsonString);

import 'dart:convert';

TeslaArticleResponseModal teslaArticleResponseModalFromJson(String str) =>
    TeslaArticleResponseModal.fromJson(json.decode(str));

String teslaArticleResponseModalToJson(TeslaArticleResponseModal data) =>
    json.encode(data.toJson());

class TeslaArticleResponseModal {
  String status;
  int totalResults;
  List<TeslaArticle> articles;

  TeslaArticleResponseModal({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory TeslaArticleResponseModal.fromJson(Map<String, dynamic> json) =>
      TeslaArticleResponseModal(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<TeslaArticle>.from(
            json["articles"].map((x) => TeslaArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class TeslaArticle {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;

  TeslaArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory TeslaArticle.fromJson(Map<String, dynamic> json) => TeslaArticle(
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