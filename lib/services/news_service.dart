
import 'package:news/services/open_client.dart';
import 'package:news/utils/constants.dart';


class NewsService{

Future<dynamic> getNewsSources() async{

  var _data = await OpenClient().get(baseUrl+'/sources?language=en&apiKey=$apiKey');

  return _data;
}

Future<dynamic> getHeadlines(String source) async{
  
  var _data = await OpenClient().get(baseUrl+'/top-headlines?sources=$source&apiKey=$apiKey');

  return _data;
}

Future<dynamic> getNigerianHeadlines() async{

  var _data = await OpenClient().get(baseUrl+'/top-headlines?country=ng&apiKey=$apiKey');

  return _data;
}



}