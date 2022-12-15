import 'package:dartz/dartz.dart';
import 'package:newsapp/core/error/error.dart';
import 'package:newsapp/core/error/exceptions.dart';
import 'package:newsapp/features/news/data/datasource/news_remote_data_source.dart';
import 'package:newsapp/features/news/domain/entities/articles.dart';
import 'package:newsapp/features/news/domain/repository/base_news_repository.dart';

class NewsRepository extends BaseNewsRepository{

  final BaseNewsRemoteDataSource baseNewsRemoteDataSource;
  NewsRepository(this.baseNewsRemoteDataSource);

  @override
  Future<Either<Failure, List<Articles>>> getEgyptArticles() async{
    final result = await baseNewsRemoteDataSource.getEgyptArticles();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, List<Articles>>> getAllNewsArticles() async{
    final result = await baseNewsRemoteDataSource.getAllNewsArticles();
    try{
      return Right(result);
    }on ServerException catch(failure){
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

}