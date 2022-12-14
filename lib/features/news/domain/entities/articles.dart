import 'package:equatable/equatable.dart';

class Articles extends Equatable {
  final String title;
  final String? urlToImage;
  final String publishedAt;

  const Articles({
   required this.title,
   required this.publishedAt,
   this.urlToImage
});

  @override
  List<Object?> get props => [title, urlToImage, publishedAt];

}