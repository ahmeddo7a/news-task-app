import 'package:dartz/dartz.dart';
import 'package:newsapp/core/base_use_case.dart';
import 'package:newsapp/core/error/error.dart';
import 'package:newsapp/features/news/domain/entities/articles.dart';
import 'package:newsapp/features/news/domain/repository/base_news_repository.dart';

class GetEgyptArticlesUseCase extends BaseUseCase<List<Articles>>{
  final BaseNewsRepository baseNewsRepository;

  GetEgyptArticlesUseCase(this.baseNewsRepository);
  @override
  Future<Either<Failure, List<Articles>>> call() async{

    return await baseNewsRepository.getEgyptArticles();
  }

}