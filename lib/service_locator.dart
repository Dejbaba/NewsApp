
import 'package:get_it/get_it.dart';
import 'package:news/services/news_service.dart';
import 'package:news/view_models/news_model.dart';

GetIt locator = GetIt();


void setupLocator(){

  // register services
  locator.registerLazySingleton<NewsService>(() => NewsService());


  // register models
  locator.registerFactory<NewsModel>(() => NewsModel());
}