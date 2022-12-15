import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newsapp/core/enum.dart';
import 'package:newsapp/core/services/service_locator.dart';
import 'package:newsapp/features/news/presentation/logic/news_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../widgets/build_all_news_articles.dart';
import '../widgets/build_egyptian_articles_widget.dart';


class NewsHome extends StatefulWidget {
  const NewsHome({Key? key}) : super(key: key);

  @override
  State<NewsHome> createState() => _NewsHomeState();
}

class _NewsHomeState extends State<NewsHome> {
  late StreamSubscription subscription;
  var isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  getConnectivity() => subscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) async {
        isDeviceConnected = await InternetConnectionChecker().hasConnection;
        if (!isDeviceConnected && isAlertSet == false) {
          showDialogBox();
          setState(() {
            isAlertSet = true;
          });
        }
      });

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myWidth = MediaQuery.of(context).size.width;
    final myHeight = MediaQuery.of(context).size.height;
    return BlocProvider(
      create: (BuildContext context)=> sl<NewsBloc>()..add(GetEgyptianArticlesEvent())..add(GetAllNewsArticlesEvent()),
      child: BlocBuilder<NewsBloc, NewsState>(
          buildWhen: (previous, current) =>
              previous.newsEgyptianArticlesState !=
              current.newsEgyptianArticlesState,
          builder: (context, state) {
            return Scaffold(
                appBar: AppBar(
                  title: const Text('NewsApp'),
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height:myHeight*0.3,child: const BuildEgyptianArticles()),
                       const Padding(
                        padding:  EdgeInsets.only(
                            top: 20.0, right: 15.0, left: 15.0, bottom: 15.0),
                        child: Text(
                          'Latest News',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepOrange),
                        ),
                      ),
                      SizedBox(
                          height: myHeight*0.5,
                          child: const BuildAllNewsArticles()),
                    ],
                  ),
                ),
            );
          }),
    );
  }

  showDialogBox() => showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
            title: const Text('No Internet Connection'),
            content: const Text('Please check your internet connection'),
            actions: [
              TextButton(
                onPressed: () async {
                  Navigator.pop(context, 'Cancel');
                  setState(() {
                    isAlertSet = false;
                  });
                  isDeviceConnected =
                      await InternetConnectionChecker().hasConnection;
                  if (!isDeviceConnected) {
                    showDialogBox();
                    setState(() {
                      isAlertSet = true;
                    });
                  }
                },
                child: const Text('Retry'),
              )
            ],
          ));
}
