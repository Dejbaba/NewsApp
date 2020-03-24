import 'package:flutter/material.dart';
import 'package:news/models/article.dart';
import 'package:news/utils/constants.dart';
import 'package:news/views/pages/full_article.dart';

class NewsDetails extends StatelessWidget {
  final Article article;

  NewsDetails(this.article);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      body: ListView(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    width: width(context),
                    height: height(context) / 2.3,
                    child: FadeInImage.assetNetwork(
                      placeholder: "assets/loading.gif",
                      image: article.urlToImage == null
                          ? defaultPlaceholder
                          : article.urlToImage,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.person,
                                          size: width(context) / 25),
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
                                            fontSize: width(context) / 30,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(Icons.date_range,
                                          size: width(context) / 25),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        article.publishedAt == null
                                            ? "No date"
                                            : dateFormatter(
                                                article.publishedAt),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: width(context) / 30,
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
                            fontSize: width(context) / 20,
                          ),
                        ),
                        SizedBox(
                          height: height(context) / 30,
                        ),
                        Text(
                          article.content == null
                              ? "No Content"
                              : article.content,
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: width(context) / 30,
                          ),
                          textAlign: TextAlign.start,
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
                  height: height(context) / 15,
                  width: width(context),
                  child: RaisedButton(
                    elevation: 3,
                    color: Colors.blue,
                    child: Text(
                      "Click to Read full article",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: width(context) / 25,
                          color: Colors.white),
                      textAlign: TextAlign.start,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return FullArticle(article.url);
                      }));
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
