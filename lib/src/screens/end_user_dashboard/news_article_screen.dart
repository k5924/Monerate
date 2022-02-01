import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsArticleScreen extends StatefulWidget {
  final String url;
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
