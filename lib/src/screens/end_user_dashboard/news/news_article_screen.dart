import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// This is the screen which would be rendered after an end-user clicks on a news article to view
class NewsArticleScreen extends StatefulWidget {
  /// This variable stores the url for the article
  final String url;

  /// This is the constructor for this screen which assigns the url for the article to the url variable
  const NewsArticleScreen({Key? key, required this.url}) : super(key: key);

  @override
  _NewsArticleScreenState createState() => _NewsArticleScreenState();
}

class _NewsArticleScreenState extends State<NewsArticleScreen> {
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        onWebViewCreated: (WebViewController webViewController) {
          _completer.complete(webViewController);
        },
        initialUrl: widget.url,
      ),
    );
  }
}
