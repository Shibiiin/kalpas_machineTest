// To parse this JSON data, do
//
//     final topHeadlineResponseModal = topHeadlineResponseModalFromJson(jsonString);

import 'dart:convert';

TopHeadlineResponseModal topHeadlineResponseModalFromJson(String str) =>
    TopHeadlineResponseModal.fromJson(json.decode(str));

String topHeadlineResponseModalToJson(TopHeadlineResponseModal data) =>
    json.encode(data.toJson());

class TopHeadlineResponseModal {
  String status;
  int totalResults;
  List<TopHeadlineArticle> articles;

  TopHeadlineResponseModal({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  factory TopHeadlineResponseModal.fromJson(Map<String, dynamic> json) =>
      TopHeadlineResponseModal(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<TopHeadlineArticle>.from(
            json["articles"].map((x) => TopHeadlineArticle.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "totalResults": totalResults,
        "articles": List<dynamic>.from(articles.map((x) => x.toJson())),
      };
}

class TopHeadlineArticle {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  TopHeadlineArticle({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory TopHeadlineArticle.fromJson(Map<String, dynamic> json) =>
      TopHeadlineArticle(
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
  Id id;
  Name name;

  Source({
    required this.id,
    required this.name,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: idValues.map[json["id"]]!,
        name: nameValues.map[json["name"]]!,
      );

  Map<String, dynamic> toJson() => {
        "id": idValues.reverse[id],
        "name": nameValues.reverse[name],
      };
}

enum Id { TECHCRUNCH }

final idValues = EnumValues({"techcrunch": Id.TECHCRUNCH});

enum Name { TECH_CRUNCH }

final nameValues = EnumValues({"TechCrunch": Name.TECH_CRUNCH});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
