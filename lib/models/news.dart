// To parse this JSON data, do
//
//     final news = newsFromJson(jsonString);

import 'dart:convert';

News newsFromJson(String str) => News.fromMap(json.decode(str));

String newsToJson(News data) => json.encode(data.toMap());

class News {
  String status;
  int totalResults;
  List<Article> articles;

  News({
    this.status,
    this.totalResults,
    this.articles,
  });

  factory News.fromMap(Map<String, dynamic> json) => News(
    status: json["status"],
    totalResults: json["totalResults"],
    articles: List<Article>.from(json["articles"].map((x) => Article.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "status": status,
    "totalResults": totalResults,
    "articles": List<dynamic>.from(articles.map((x) => x.toMap())),
  };
}

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromMap(Map<String, dynamic> json) => Article(
    source: Source.fromMap(json["source"]),
    author: json["author"],
    title: json["title"],
    description: json["description"],
    url: json["url"],
    urlToImage: json["urlToImage"] == null ? null : json["urlToImage"],
    publishedAt: DateTime.parse(json["publishedAt"]),
    content: json["content"] == null ? null : json["content"],
  );

  Map<String, dynamic> toMap() => {
    "source": source.toMap(),
    "author": author,
    "title": title,
    "description": description,
    "url": url,
    "urlToImage": urlToImage == null ? null : urlToImage,
    "publishedAt": publishedAt.toIso8601String(),
    "content": content == null ? null : content,
  };
}

class Source {
  String id;
  String name;

  Source({
    this.id,
    this.name,
  });

  factory Source.fromMap(Map<String, dynamic> json) => Source(
    id: json["id"] == null ? null : json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "name": name,
  };
}
