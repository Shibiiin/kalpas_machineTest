// To parse this JSON data, do
//
//     final wallStreetArticleResponseModal = wallStreetArticleResponseModalFromJson(jsonString);

import 'dart:convert';

WallStreetArticleResponseModal wallStreetArticleResponseModalFromJson(
        String str) =>
    WallStreetArticleResponseModal.fromJson(json.decode(str));

String wallStreetArticleResponseModalToJson(
        WallStreetArticleResponseModal data) =>
    json.encode(data.toJson());

class WallStreetArticleResponseModal {
  String status;
  int totalResults;
  List<WallStreetArticle> articles;

  WallStreetArticleResponseModal({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory WallStreetArticleResponseModal.fromJson(Map<String, dynamic> json) =>
      WallStreetArticleResponseModal(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<WallStreetArticle>.from(
            json["articles"].map((x) => WallStreetArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class WallStreetArticle {
  Source source;
  String author;
  String title;
  dynamic description;
  String url;
  dynamic urlToImage;
  DateTime publishedAt;
  String content;

  WallStreetArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory WallStreetArticle.fromJson(Map<String, dynamic> json) =>
      WallStreetArticle(
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
  String id;
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
