import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news/enums/connectivity_status.dart';
import 'package:news/models/article.dart';
import 'package:news/utils/color.dart';
import 'package:news/utils/constants.dart';
import 'package:news/utils/theme.dart';
import 'package:news/view_models/news_model.dart';
import 'package:news/views/pages/news_details.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _Home();
  }
}

class _Home extends State<Home> {
  bool value = true;
  var fetchStatus;
  var fetchHeadlines;
  var position;
  var connectionState;
  List<dynamic> headLines;
  bool showSource = false;
  bool showProgressIndicator = true;
  bool showStoryBoard = false;
  ThemeChanger themeChanger;
  ThemeData getTheme;
  NewsModel newsModel;

  InkWell categories(BuildContext context, Color color, String category,
          List<String> categoryType, int index, var connectionState) =>
      InkWell(
        onTap: () async {
          if (connectionState == ConnectivityStatus.Offline) {
            showSource = false;
          } else {
            setState(() {
              showSource = true;
            });
          }
          await _fetchNewSources(categoryType, index, category);
        },
        child: Padding(
          padding: EdgeInsets.only(right: width(context) / 30),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(width(context) / 20),
            clipBehavior: Clip.antiAlias,
            child: Container(
                width: width(context) / 4.5,
                color: color,
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(width(context) / 100),
                    child: Text(
                      category,
                      style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: width(context) / 36,
                          color: Colors.white),
                    ),
                  ),
                )),
          ),
        ),
      );

  InkWell sources(BuildContext context, Color color, String sourceName) =>
      InkWell(
        onTap: () async {
          await getHeadlines(sourceName);
          setState(() {
            showStoryBoard = true;
          });
        },
        child: Padding(
          padding: EdgeInsets.only(right: width(context) / 80),
          child: Container(
            width: width(context) / 6,
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: width(context) / 15,
                  backgroundImage: AssetImage("assets/images/${imageFileName(sourceName)}.jpg"),

                  /*child: Text(
                    sourceName[0].toUpperCase(),
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        fontSize: width(context) / 15),
                  ),*/
                ),
                Text(
                  imageName(sourceName),
                  style: TextStyle(
                      fontWeight: FontWeight.w800, fontSize: width(context) / 40),
                  textAlign: TextAlign.center,
                ),

              ],
            ),
          ),
        ),
      );

  InkWell storyBoard(BuildContext context, Article article, int index) =>
      InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return new NewsDetails(article);
            }));
          },
          child: Card(
            elevation: 2,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            child: Stack(
              children: <Widget>[
                Image.asset(
                  "assets/loading.gif",
                  height: height(context),
                  width: width(context),
                  fit: BoxFit.fill,
                ),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.4), BlendMode.hardLight),
                    image: new NetworkImage(
                      article.urlToImage == null
                          ? defaultPlaceholder
                          : article.urlToImage,
                    ),
                    fit: BoxFit.cover,
                  )),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: width(context) / 40, right: width(context) / 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          article.title == null ? "No title" : article.title,
                          style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: width(context) / 20,
                              color: Colors.white),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                              size: width(context) / 25,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Flexible(
                              //flex: 2,
                              child: Text(
                                article.author == null
                                    ? "No author"
                                    : article.author,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: width(context) / 35,
                                    color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                softWrap: true,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height(context) / 90,
                        ),
                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(width(context) / 30),
                          clipBehavior: Clip.antiAlias,
                          child: Container(
                            color: Colors.blue,
                            height: height(context) / 30,
                            width: width(context) / 5,
                            child: Center(
                              child: Text(
                                "Read",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: width(context) / 25,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 80,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));

  @override
  void initState() {
    super.initState();

    newsModel = new NewsModel();
  }

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
            "Home",
            style: TextStyle(fontWeight: FontWeight.w800, color: Colors.white),
          ),
          elevation: 1.0,
        ),
        body: Container(
          height: height(context),
          width: width(context),
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
              Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: width(context) / 20),
                    ),
                  ),
                  SizedBox(
                    height: height(context) / 100,
                  ),
                  Container(
                    height: height(context) / 28,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      //physics: AlwaysScrollableScrollPhysics(),
                      //shrinkWrap: true,
                      itemCount: newsCategory.length,
                      itemBuilder: (BuildContext context, int index) {
                        return categories(
                            context,
                            getColor(index),
                            newsCategory[index],
                            listOfCategories[index],
                            index,
                            connectionState);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height(context) / 60,
              ),
              showSource
                  ? Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "News Source(s)",
                        style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: width(context) / 20),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: height(context) / 100,
              ),
              showSource
                  ? FutureBuilder(
                      future: _fetchStatus(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return Center(child: Column(
                            children: <Widget>[
                              CircularProgressIndicator(),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Fetching News Source",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: width(context) / 45),
                              ),
                            ],
                          ));
                        } else {
                          return Container(
                            height: height(context) / 6,
                            child: Stack(
                              children: <Widget>[
                                showProgressIndicator
                                    ? Center(
                                        child: Column(
                                        children: <Widget>[
                                          CircularProgressIndicator(),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            "Fetching News Source",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: width(context) / 45),
                                          ),
                                        ],
                                      ))
                                    : Container(),
                                !showProgressIndicator
                                    ? ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: newsModel
                                            .categoryList[position].length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return sources(
                                              context,
                                              getColor(position),
                                              newsModel.categoryList[position]
                                                  [index]);
                                        },
                                      )
                                    : Container()
                              ],
                            ),
                          );
                        }
                      })
                  : Container(),
              SizedBox(
                height: height(context) / 50,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Stories",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: width(context) / 20),
                ),
              ),
              SizedBox(
                height: height(context) / 90,
              ),
              connectionState == ConnectivityStatus.Offline
                  ? Expanded(
                      child: Container(
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
                      ),
                    )
                  : showStoryBoard
                      ? Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(bottom: height(context) / 20),
                            child: FutureBuilder(
                                future: _fetchHeadlinesStatus(),
                                builder: (context, AsyncSnapshot snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else {
                                    return Container(
                                      width: width(context),
                                      child: Swiper(
                                        itemCount: headLines.length,
                                        itemHeight: height(context) / 2.0,
                                        itemWidth: width(context) / 1.3,
                                        layout: SwiperLayout.STACK,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return storyBoard(
                                              context,
                                              Article.fromJson(
                                                  headLines[index]),
                                              index);
                                        },
                                      ),
                                    );
                                  }
                                }),
                          ),
                        )
                      : Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: width(context) / 100),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: height(context) / 4,
                                  width: width(context),
                                  // padding: EdgeInsets.only(left: width(context) / 7),
                                  child: FlareActor(
                                    'assets/anim/empty_state.flr',
                                    animation: 'idle',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                Text(
                                  "NO STORIES YET",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
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

  /*filterNewSource(List<String> categoryType, int index, String category) async{
   await  _fetchNewSources();
    if (fetchStatus) {
      categoryType = newsModel.categoryList[index];
      position = index;
      print("$category Category: $categoryType :::: ${categoryType.length}");
    }
  }*/

  getHeadlines(String sourceName) async {
    fetchHeadlines = await newsModel.getHeadlines(sourceName);
    if (fetchHeadlines) {
      headLines = newsModel.articleList;
      print("Headlines from $sourceName: $headLines");
    }
  }

  _fetchNewSources(
      List<String> categoryType, int index, String category) async {
    setState(() {
      showProgressIndicator = true;
    });
    fetchStatus = await newsModel.getNewsSources();
    if (fetchStatus) {
      categoryType = newsModel.categoryList[index];
      position = index;
      print("$category Category: $categoryType :::: ${categoryType.length}");
    }
    setState(() {
      showProgressIndicator = false;
    });
  }

  _fetchStatus() async {
    return fetchStatus;
  }

  _fetchHeadlinesStatus() async {
    return fetchHeadlines;
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
