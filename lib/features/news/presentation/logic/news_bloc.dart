import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:newsapp/core/base_use_case.dart';
import 'package:newsapp/core/enum.dart';
import 'package:newsapp/features/news/domain/entities/articles.dart';

import '../../domain/use_case/get_all_news_use_case.dart';
import '../../domain/use_case/get_articles_use_case.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetEgyptArticlesUseCase getEgyptArticlesUseCase;
  final GetAllNewsUseCase getAllNewsUseCase;

  NewsBloc(
    this.getEgyptArticlesUseCase,this.getAllNewsUseCase,
  ) : super(const NewsState()) {
    on<GetEgyptianArticlesEvent>(_getEgyptArticles);
    on<GetAllNewsArticlesEvent>(_getAllNewsArticles);
  }

  FutureOr<void> _getEgyptArticles(
      GetEgyptianArticlesEvent event, Emitter<NewsState> emit) async {
    final result = await getEgyptArticlesUseCase();
    result.fold(
        (l) => emit(state.copywith(
            newsEgyptianArticlesState: RequestState.error,
            newsEgyptianArticlesMessage: l.message)),
        (r) {
          r.removeWhere((element) => element.urlToImage ==null);
          emit(state.copywith(
            newsEgyptianArticles: r,
            newsEgyptianArticlesState: RequestState.loaded));});

  }


  FutureOr<void> _getAllNewsArticles(GetAllNewsArticlesEvent event, Emitter<NewsState> emit) async{
    final result = await getAllNewsUseCase();
    result.fold(
            (l) => emit(state.copywith(
            allNewsArticlesState: RequestState.error,
            allNewsArticlesMessage: l.message)),
            (r) {
          r.removeWhere((element) => element.urlToImage ==null || element.description ==null || element.content == null);
          emit(state.copywith(
              allNewsArticles: r,
              allNewsArticlesState: RequestState.loaded));});
  }
}
