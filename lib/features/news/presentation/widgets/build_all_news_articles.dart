import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/features/news/presentation/logic/news_bloc.dart';

class BuildAllNewsArticles extends StatelessWidget {
  const BuildAllNewsArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc,NewsState>(
      buildWhen: (previous,current)=>previous.allNewsArticlesState != current.allNewsArticlesState,
      builder: (BuildContext context, state) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: state.allNewsArticles.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 20.0),
            child: Container(
              width: double.infinity,
              height: 105,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: CachedNetworkImage(
                        imageUrl: state.allNewsArticles[index].urlToImage!,
                        fit: BoxFit.cover,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                            Center(
                              child: CircularProgressIndicator(
                                value: downloadProgress.progress,
                                strokeWidth: 3,
                              ),
                            ),
                        errorWidget: (context, url, error) =>
                            const Icon(
                              Icons.error,
                              color: Colors.deepOrange,
                            ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.allNewsArticles[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          Row(
                            //textBaseline: TextBaseline.ideographic,
                            //crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                size: 16,
                                color: Colors.deepOrange,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                state.allNewsArticles[index].publishedAt,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },

    );
  }
}
