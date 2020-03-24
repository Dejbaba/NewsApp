import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class FullArticle extends StatefulWidget{

  final String url;

  FullArticle(this.url);

  @override
  State<StatefulWidget> createState() {
    return _FullArticle(url);
  }
}

class _FullArticle extends State<FullArticle>{


  String url;

  _FullArticle(this.url);

  WebViewController _controller;





  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebView(
              initialUrl: url,
              onWebViewCreated: (WebViewController webViewController) {
                _controller = webViewController;

              },
            )),
      );

  }

}








