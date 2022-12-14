import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:newsapp/features/news/presentation/logic/news_bloc.dart';

import '../../../../core/enum.dart';

class BuildEgyptianArticles extends StatelessWidget {
  const BuildEgyptianArticles({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state.newsEgyptianArticlesState == RequestState.loaded,
          builder: (context) => Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: CarouselSlider.builder(
              itemCount: state.newsEgyptianArticles.length,
              itemBuilder: (context, index, s) {
                return Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        width: 1000,
                        imageUrl: state.newsEgyptianArticles[index].urlToImage!,
                        fit: BoxFit.cover,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          padding: const EdgeInsets.all(8.6),
                          color: Colors.black.withOpacity(0.5),
                          width: double.infinity,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.newsEgyptianArticles[index].title,
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              const SizedBox(
                                height: 5,
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
                                    state.newsEgyptianArticles[index]
                                        .publishedAt,
                                    style: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 11,
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
                );
              },
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
            ),
          ),
          fallback: (context) => Center(
            child: LoadingAnimationWidget.flickr(
              leftDotColor: const Color(0xFF1A1A3F),
              rightDotColor: const Color(0xFFEA3799),
              size: 50,
            ),
          ),
        );
      },
    );
  }
}
