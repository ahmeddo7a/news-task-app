import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/error.dart';
import 'package:newsapp/features/news/domain/entities/articles.dart';

abstract class BaseNewsRepository{

  Future<Either<Failure,List<Articles>>> getEgyptArticles();
}