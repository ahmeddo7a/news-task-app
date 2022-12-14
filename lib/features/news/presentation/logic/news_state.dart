part of 'news_bloc.dart';

class NewsState extends Equatable {
  final List<Articles> newsEgyptianArticles;
  final RequestState newsEgyptianArticlesState;
  final String newsEgyptianArticlesMessage;

  const NewsState(
      {this.newsEgyptianArticles = const [],
      this.newsEgyptianArticlesState = RequestState.loading,
      this.newsEgyptianArticlesMessage = ''});

  NewsState copywith({
    List<Articles>? newsEgyptianArticles,
    RequestState? newsEgyptianArticlesState,
    String? newsEgyptianArticlesMessage,
}){
    return NewsState(
      newsEgyptianArticles: newsEgyptianArticles?? this.newsEgyptianArticles,
      newsEgyptianArticlesState: newsEgyptianArticlesState ?? this.newsEgyptianArticlesState,
      newsEgyptianArticlesMessage: newsEgyptianArticlesMessage?? this.newsEgyptianArticlesMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        newsEgyptianArticles,
        newsEgyptianArticlesState,
        newsEgyptianArticlesMessage
      ];
}
