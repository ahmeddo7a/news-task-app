import 'package:equatable/equatable.dart';

class Articles extends Equatable {
  final String title;
  final String? urlToImage;
  final String publishedAt;
  final String? description;
  final String? content;

  const Articles({
   required this.title,
   required this.publishedAt,
   this.urlToImage,
    this.description,
    this.content

});

  @override
  List<Object?> get props => [title, urlToImage, publishedAt,description,content];

}