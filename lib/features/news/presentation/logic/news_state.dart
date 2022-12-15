part of 'news_bloc.dart';

class NewsState extends Equatable {
  final List<Articles> newsEgyptianArticles;
  final RequestState newsEgyptianArticlesState;
  final String newsEgyptianArticlesMessage;
  final List<Articles> allNewsArticles;
  final RequestState allNewsArticlesState;
  final String allNewsArticlesMessage;

  const NewsState(
      {this.newsEgyptianArticles = const [],
      this.newsEgyptianArticlesState = RequestState.loading,
      this.newsEgyptianArticlesMessage = '',
        this.allNewsArticles = const[],
        this.allNewsArticlesState = RequestState.loading,
        this.allNewsArticlesMessage = '',
      });

  NewsState copywith({
    List<Articles>? newsEgyptianArticles,
    RequestState? newsEgyptianArticlesState,
    String? newsEgyptianArticlesMessage,
    List<Articles>? allNewsArticles,
    RequestState? allNewsArticlesState,
    String? allNewsArticlesMessage,
}){
    return NewsState(
      newsEgyptianArticles: newsEgyptianArticles?? this.newsEgyptianArticles,
      newsEgyptianArticlesState: newsEgyptianArticlesState ?? this.newsEgyptianArticlesState,
      newsEgyptianArticlesMessage: newsEgyptianArticlesMessage?? this.newsEgyptianArticlesMessage,
      allNewsArticles: allNewsArticles?? this.allNewsArticles,
      allNewsArticlesState: allNewsArticlesState?? this.allNewsArticlesState,
      allNewsArticlesMessage: allNewsArticlesMessage?? this.allNewsArticlesMessage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        newsEgyptianArticles,
        newsEgyptianArticlesState,
        newsEgyptianArticlesMessage,
        allNewsArticles,
        allNewsArticlesState,
        allNewsArticlesMessage,
      ];
}
