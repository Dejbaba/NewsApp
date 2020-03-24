
import 'package:flutter/material.dart';
import 'package:news/enums/connectivity_status.dart';
import 'package:news/models/article.dart';
import 'package:news/services/connectivity_service.dart';
import 'package:news/utils/theme.dart';
import 'package:news/views/pages/home.dart';
import 'package:news/views/pages/landing.dart';
import 'package:news/views/pages/news_details.dart';
import 'package:news/views/pages/nigerian_news.dart';
import 'package:provider/provider.dart';


import 'service_locator.dart';




void main() {

  setupLocator();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeChanger>(
      builder: (_) => ThemeChanger(ThemeData.dark(

      )),
      child: new MaterialAppWithTheme(),
    );
  }
}

class MaterialAppWithTheme extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeChanger>(context);
    return StreamProvider<ConnectivityStatus>(
      builder: (context) => ConnectivityService().connectionStatusController,
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: theme.getTheme(),
          home: Landing(),
          routes: <String, WidgetBuilder> {
            '/home' : (BuildContext context) => Home(),
            '/nigerianNews' : (BuildContext context) => NigerianNews(),

          }
      ),
    );
  }
}



