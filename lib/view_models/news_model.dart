import 'dart:convert';

import 'package:news/enums/view_state.dart';
import 'package:news/models/article.dart';
import 'package:news/models/article_response.dart';
import 'package:news/models/source.dart';
import 'package:news/models/source.dart';
import 'package:news/models/source.dart';
import 'package:news/models/source_response.dart';
import 'package:news/service_locator.dart';
import 'package:news/services/news_service.dart';
import 'package:news/view_models/base_model.dart';




class NewsModel extends BaseModel{

  NewsService newsService =  locator<NewsService>();

  List<dynamic> sourceList;
  List<dynamic> articleList;
  List<dynamic> nigerianArticles;
  List<List<String>> categoryList;
  List<String> business = new List();
  List<String> entertainment = new List();
  List<String> general = new List();
  List<String> health = new List();
  List<String> science = new List();
  List<String> sports = new List();
  List<String> technology = new List();


  Future<bool> getNewsSources() async{

    setState(ViewState.Busy);
    var _resp = await newsService.getNewsSources();
    var _json = json.decode(_resp);
    sourceList = _json["sources"];

    clearEachCategory();

    for(int i = 0; i < sourceList.length; i++){
      filterCategory(Source.fromJson(sourceList[i]));
    }

    populateCategoryList();

    printCategories();

    var sourceResponse = SourceResponse.fromJson(_json);

    if(sourceResponse.status == "ok"){
      return true;
    }else{
      print("Error Occured Somewhere");
      return false;
    }

  }

  Future<bool> getHeadlines(String source) async{

    setState(ViewState.Busy);
    var _resp = await newsService.getHeadlines(source);
    var _json = json.decode(_resp);
    articleList = _json["articles"];

    //remove this later
    return true;

  }

  Future<bool> getNigerianHeadlines() async{

    setState(ViewState.Busy);
    var _resp = await newsService.getNigerianHeadlines();
    var _json = json.decode(_resp);
    nigerianArticles = _json["articles"];




    var articleResponse = ArticleResponse.fromJson(_json);

    if(articleResponse.status == "ok"){
      return true;
    }else{
      return false;
    }

  }

  void printCategories() {
    print("Business Category: $business");
    print("Entertainment Category: $entertainment");
    print("General Category: $general");
    print("Health Category: $health");
    print("Science Category: $science");
    print("Sports Category: $sports");
    print("Technology Category: $technology");
  }

  void populateCategoryList() {
    categoryList = [business,
    entertainment,
    general,
    health,
    science,
    sports,
    technology];
  }

  void clearEachCategory(){
    business.clear();
    entertainment.clear();
    general.clear();
    health.clear();
    science.clear();
    sports.clear();
    technology.clear();
  }

  void filterCategory(Source source){

    switch(source.category){

      case "business":
        business.add(source.id);
        break;

      case "entertainment":
        entertainment.add(source.id);
        break;

      case "general":
        general.add(source.id);
        break;

      case "health":
        health.add(source.id);
        break;

      case "science":
        science.add(source.id);
        break;

      case "sports":
        sports.add(source.id);
        break;

      case "technology":
        technology.add(source.id);
        break;



    }
  }



}