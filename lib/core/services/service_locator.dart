import 'package:get_it/get_it.dart';
import 'package:newsapp/features/news/data/datasource/news_remote_data_source.dart';
import 'package:newsapp/features/news/data/repository/news_repository.dart';
import 'package:newsapp/features/news/domain/repository/base_news_repository.dart';
import 'package:newsapp/features/news/domain/use_case/get_all_news_use_case.dart';
import 'package:newsapp/features/news/domain/use_case/get_articles_use_case.dart';
import 'package:newsapp/features/news/presentation/logic/news_bloc.dart';

final sl = GetIt.instance;
class ServiceLocator{
  void init(){
    /// News Bloc
    sl.registerFactory(() => NewsBloc(sl(),sl()));


    ///UseCase
    sl.registerLazySingleton(() => GetEgyptArticlesUseCase(sl()));
    sl.registerLazySingleton(() => GetAllNewsUseCase(sl()));



    ///Repository
    sl.registerLazySingleton<BaseNewsRepository>(() => NewsRepository(sl()));

    ///DataSource
    sl.registerLazySingleton<BaseNewsRemoteDataSource>(() => NewsRemoteDataSource());
  }
}