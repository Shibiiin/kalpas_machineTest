// To parse this JSON data, do
//
//     final topBusinessResponseModal = topBusinessResponseModalFromJson(jsonString);

import 'dart:convert';

TopBusinessResponseModal topBusinessResponseModalFromJson(String str) =>
    TopBusinessResponseModal.fromJson(json.decode(str));

String topBusinessResponseModalToJson(TopBusinessResponseModal data) =>
    json.encode(data.toJson());

class TopBusinessResponseModal {
  String status;
  int totalResults;
  List<TopBusinessArticle> articles;

  TopBusinessResponseModal({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory TopBusinessResponseModal.fromJson(Map<String, dynamic> json) =>
      TopBusinessResponseModal(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<TopBusinessArticle>.from(
            json["articles"].map((x) => TopBusinessArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class TopBusinessArticle {
  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String? content;

  TopBusinessArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory TopBusinessArticle.fromJson(Map<String, dynamic> json) =>
      TopBusinessArticle(
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
