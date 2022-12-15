import 'package:newsapp/core/app_constants.dart';
import 'package:newsapp/core/error/error_model.dart';
import 'package:newsapp/core/error/exceptions.dart';
import 'package:newsapp/features/news/data/models/articles_model.dart';
import 'package:dio/dio.dart';

abstract class BaseNewsRemoteDataSource {
  Future<List<ArticlesModel>> getEgyptArticles();
  Future<List<ArticlesModel>> getAllNewsArticles();
}

class NewsRemoteDataSource extends BaseNewsRemoteDataSource {
  @override
  Future<List<ArticlesModel>> getEgyptArticles() async {
    final response = await Dio().get(AppConstants.egyptNews);
    if(response.statusCode==200){
      return List<ArticlesModel>.from(
        (response.data['articles'] as List)
            .map(
                (e) => ArticlesModel.fromJson(e)),
      );
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }

  @override
  Future<List<ArticlesModel>> getAllNewsArticles() async{
    final response = await Dio().get(AppConstants.allNews);
    if(response.statusCode==200){
      return List<ArticlesModel>.from(
        (response.data['articles'] as List)
            .map(
                (e) => ArticlesModel.fromJson(e)),
      );
    }else{
      throw ServerException(errorMessageModel: ErrorMessageModel.fromJson(response.data));
    }
  }
}
