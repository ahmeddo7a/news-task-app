import '../../domain/entities/articles.dart';

class ArticlesModel extends Articles {
  const ArticlesModel({
    required super.title,
    super.urlToImage,
    required super.publishedAt,
    super.description,
    super.content
  });

  factory ArticlesModel.fromJson(Map<String, dynamic> json) =>
      ArticlesModel(
          title: json['title'],
          urlToImage: json['urlToImage'],
          publishedAt: json['publishedAt'],
          description: json['description'],
          content: json['content'],
      );
}