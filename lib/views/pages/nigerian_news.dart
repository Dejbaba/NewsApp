import 'package:flare_flutter/flare_actor.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news/enums/connectivity_status.dart';
import 'package:news/models/article.dart';
import 'package:news/utils/color.dart';
import 'package:news/utils/constants.dart';
import 'package:news/utils/theme.dart';
import 'package:news/view_models/news_model.dart';
import 'package:provider/provider.dart';

class NigerianNews extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _NigerianNews();
  }
}

class _NigerianNews extends State<NigerianNews> {
  List<dynamic> nigerianHeadlines;
  NewsModel newsModel;
  bool value;
  bool internet = false;
  var fetchHeadlines;
  var fetchStatus;
  var connectionState;
  ThemeChanger themeChanger;
  ThemeData getTheme;

  @override
  void initState() {
    super.initState();

    newsModel = new NewsModel();
    fetchStatus = _getNigerianHeadlines();
  }

  Card headlineLayout(BuildContext context, Article article) => Card(
        //color: value ? Colors.blueGrey : Colors.grey,
        elevation: 5,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: height(context) / 3,
                  width: width(context),
                  child: new FadeInImage.assetNetwork(
                    image: article.urlToImage == null
                        ? defaultPlaceholder
                        : article.urlToImage,
                    placeholder: "assets/loading.gif",
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: height(context) / 90,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: width(context) / 25, right: width(context) / 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Card(
                              //color: Colors.white,
                              elevation: 3,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.person,
                                        size: width(context) / 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Flexible(
                                      child: Text(
                                        article.author == null
                                            ? "No author"
                                            : article.author,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width(context) / 35,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: width(context) / 40,
                          ),
                          Flexible(
                            flex: 1,
                            fit: FlexFit.tight,
                            child: Card(
                              elevation: 3,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(Icons.date_range,
                                        size: width(context) / 30),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      article.publishedAt == null
                                          ? "No date"
                                          : dateFormatter(
                                              article.publishedAt,
                                            ),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: width(context) / 35,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: height(context) / 80,
                      ),
                      Text(
                        article.title == null ? "No Title" : article.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width(context) / 25,
                        ),
                      ),
                      SizedBox(
                        height: height(context) / 30,
                      ),
                      Container(
                        child: Text(
                          article.content == null
                              ? "No Content"
                              : article.content,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: width(context) / 35,
                          ),
                          textAlign: TextAlign.start,
                          softWrap: true,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: width(context) / 25,
                  right: width(context) / 25,
                  bottom: height(context) / 40,
                  top: height(context) / 40),
              child: Container(
                height: height(context) / 20,
                width: width(context),
                child: RaisedButton(
                  elevation: 5,
                  //color: Colors.blue,
                  child: Text(
                    "Click to Read full article",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: width(context) / 30,
                      //color: Colors.white
                    ),
                    textAlign: TextAlign.start,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    themeChanger = Provider.of<ThemeChanger>(context);
    connectionState = Provider.of<ConnectivityStatus>(context);
    setToggleButtonState();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Nigerian News",
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          ),
          elevation: 1.0,
        ),
        body: Padding(
          padding: EdgeInsets.only(
              left: width(context) / 30, right: width(context) / 30),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.wb_sunny,
                    color: Colors.orangeAccent,
                    size: width(context) / 20,
                  ),
                  Switch(
                    activeColor: blue,
                    inactiveTrackColor: Colors.orangeAccent,
                    activeTrackColor: Colors.grey,
                    inactiveThumbColor: Colors.orangeAccent,
                    value: value,
                    onChanged: (bool state) {
                      setState(() {
                        value = state;
                        switchTheme(value);
                      });
                    },
                  ),
                  Icon(
                    Icons.wb_cloudy,
                    color: Colors.grey,
                    size: width(context) / 20,
                  ),
                ],
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: connectionState == ConnectivityStatus.WiFi ||
                            connectionState == ConnectivityStatus.Cellular
                        ? _getNigerianHeadlines()
                        : fetchStatus,
                    builder: (context, AsyncSnapshot snapshot) {
                      return connectionState == ConnectivityStatus.WiFi ||
                              connectionState == ConnectivityStatus.Cellular
                          ? internetAvailable(snapshot, context)
                          : noInternetAvailable(snapshot, context);
                    },
                  ),
                ),
              ),
              connectionState == ConnectivityStatus.Offline
                  ? Container(
                      width: width(context),
                      height: height(context) / 20,
                      child: Card(
                          color: Colors.red,
                          elevation: 2,
                          child: Center(
                            child: Text(
                              "OOPs! No Internet. Check your internet",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  SingleChildRenderObjectWidget internetAvailable(
      AsyncSnapshot snapshot, BuildContext context) {
    if (!snapshot.hasData) {
      print("hello!");
      return Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircularProgressIndicator(),
          SizedBox(
            height: height(context) / 60,
          ),
          Text(
            "Loading Stories...",
            style: TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ));
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: height(context) / 60),
        child: Swiper(
          itemCount: nigerianHeadlines.length,
          itemHeight: height(context) / 1.1,
          itemWidth: width(context) / 1.2,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            return headlineLayout(
                context, Article.fromJson(nigerianHeadlines[index]));
          },
        ),
      );
    }
  }

  Widget noInternetAvailable(AsyncSnapshot snapshot, BuildContext context) {
    if (!snapshot.hasData && internet == false) {
      return Container(
        height: height(context),
        width: width(context),
        // padding: EdgeInsets.only(left: width(context) / 7),
        child: Padding(
          padding: EdgeInsets.only(left: width(context) / 5),
          child: FlareActor(
            'assets/anim/nointernet.flr',
            animation: 'idle',
            fit: BoxFit.contain,
          ),
        ),
      );
      /*Text(
                    "NO INTERNET!!",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                    ),
                  ),*/

    } else if (internet == false) {
      return Container(
        height: height(context),
        width: width(context),
        // padding: EdgeInsets.only(left: width(context) / 7),
        child: Padding(
          padding: EdgeInsets.only(left: width(context) / 5),
          child: FlareActor(
            'assets/anim/nointernet.flr',
            animation: 'idle',
            fit: BoxFit.contain,
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(bottom: height(context) / 60),
        child: Swiper(
          itemCount: nigerianHeadlines.length,
          itemHeight: height(context) / 1.1,
          itemWidth: width(context) / 1.2,
          layout: SwiperLayout.STACK,
          itemBuilder: (BuildContext context, int index) {
            return headlineLayout(
                context, Article.fromJson(nigerianHeadlines[index]));
          },
        ),
      );
    }
  }

  switchTheme(bool choice) {
    switch (choice) {
      case true:
        themeChanger.setTheme(ThemeData.dark());
        break;
      case false:
        themeChanger.setTheme(ThemeData.light());
        break;

      default:
        themeChanger.setTheme(ThemeData.light());
    }
  }

  _getNigerianHeadlines() async {
    fetchHeadlines = await newsModel.getNigerianHeadlines();
    if (fetchHeadlines) {
      nigerianHeadlines = newsModel.nigerianArticles;
      setState(() {
        internet = true;
      });
      return fetchHeadlines;
    } else {
      return false;
    }
  }

  setToggleButtonState() {
    getTheme = themeChanger.getTheme();
    if (getTheme == ThemeData.light()) {
      value = false;
    } else {
      value = true;
    }
  }
}
