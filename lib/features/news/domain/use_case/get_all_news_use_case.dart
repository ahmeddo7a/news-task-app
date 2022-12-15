import 'package:dartz/dartz.dart';
import 'package:newsapp/core/base_use_case.dart';
import 'package:newsapp/core/error/error.dart';
import 'package:newsapp/features/news/domain/repository/base_news_repository.dart';

import '../entities/articles.dart';

class GetAllNewsUseCase extends BaseUseCase<List<Articles>>{
  final BaseNewsRepository baseNewsRepository;
  GetAllNewsUseCase(this.baseNewsRepository);

  @override
  Future<Either<Failure, List<Articles>>> call() async{
          return await baseNewsRepository.getAllNewsArticles();
      }
}
