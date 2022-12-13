import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text('NewsApp'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CarouselSlider.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index, s) {
                      return Container(
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              width: 1000,
                              imageUrl: list[index]['urlToImage'],
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: CircularProgressIndicator(
                                  value: downloadProgress.progress,
                                  strokeWidth: 3,
                                ),
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                color: Colors.deepOrange,
                              ),
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
                                      list[index]['title'],
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      //textBaseline: TextBaseline.ideographic,
                                      //crossAxisAlignment: CrossAxisAlignment.baseline,
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 16,
                                          color: Colors.deepOrange,
                                        ),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        Text(
                                          list[index]['publishedAt'],
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
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
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
                Padding(
                  padding: const EdgeInsets.only(
                      top: 20.0, right: 15.0, left: 15.0, bottom: 15.0),
                  child: Text(
                    'Recent News',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.deepOrange),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(
                        left: 15.0, right: 15.0, bottom: 20.0),
                    child: Container(
                      width: double.infinity,
                      height: 105,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: Theme.of(context).backgroundColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: list[index]['urlToImage'],
                                fit: BoxFit.cover,
                                progressIndicatorBuilder:
                                    (context, url, downloadProgress) => Center(
                                  child: CircularProgressIndicator(
                                    value: downloadProgress.progress,
                                    strokeWidth: 3,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Icon(
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    list[index]['title'],
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                  Row(
                                    //textBaseline: TextBaseline.ideographic,
                                    //crossAxisAlignment: CrossAxisAlignment.baseline,
                                    children: [
                                      Icon(
                                        Icons.watch_later_outlined,
                                        size: 16,
                                        color: Colors.deepOrange,
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        list[index]['publishedAt'],
                                        style: TextStyle(
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
                ),
              ],
            ),
          ),
        ));
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
