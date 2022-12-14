import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:newsapp/core/enum.dart';
import 'package:newsapp/features/news/domain/entities/articles.dart';

import '../../domain/use_case/get_articles_use_case.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetEgyptArticlesUseCase getEgyptArticlesUseCase;

  NewsBloc(
    this.getEgyptArticlesUseCase,
  ) : super(const NewsState()) {
    on<GetEgyptianArticlesEvent>(_getEgyptArticles);
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

}
