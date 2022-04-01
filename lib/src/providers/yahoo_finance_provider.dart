// ignore_for_file: avoid_dynamic_calls

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';

/// This class allows us to communicate with the Yahoo Finance API
class YahooFinanceProvider {
  /// This variable stores an instance of Firebase Remote Config
  final RemoteConfigProvider remoteConfigProvider =
      RemoteConfigProvider(remoteConfig: FirebaseRemoteConfig.instance);

  /// This variable stores the base url for the yahoo finance API
  final String url = "yh-finance.p.rapidapi.com";

  /// This variable will store our developer API key
  late String apiKey;

  /// This variable stores a list of all new articles in ArticleModel format
  List<ArticleModel> news = [];

  /// This variable stores a list of all investments in TickerModel format
  List<TickerModel> tickers = [];

  /// This constructor calls the getAPIKeys method when the constructor of this class is called
  YahooFinanceProvider() {
    _getAPIKey();
  }

  Future<void> _getAPIKey() async {
    apiKey = await remoteConfigProvider.getYahooFinanceAPIKey();
  }

  /// This method retrieves an updated list of news articles
  Future<Object> getNewsArticles() async {
    await _getAPIKey();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/news/v2/list',
      parameters: null,
      headers: {
        'content-type': 'text/plain',
        'x-rapidapi-host': url,
        'x-rapidapi-key': apiKey,
      },
      body: null,
    );
    final newsArticles = await externalAPIProvider.postData();
    if (newsArticles.runtimeType == int) {
      return "error";
    } else if (newsArticles["status"] == "OK") {
      newsArticles["data"]["main"]["stream"].forEach((element) {
        if (element["content"]["clickThroughUrl"] != null &&
            element["content"]["thumbnail"] != null) {
          final ArticleModel articleModel = ArticleModel(
            title: element["content"]["title"] as String,
            thumbnailURL: element["content"]["thumbnail"]["resolutions"][0]
                ["url"] as String,
            url: element["content"]["clickThroughUrl"]["url"] as String,
            provider: element["content"]["provider"]["displayName"] as String,
          );
          news.add(articleModel);
        }
      });
      return news;
    } else {
      return "error";
    }
  }

  /// This method returns a list of investments based on a search term
  Future<Object> getTickerSymbol({
    required String searchParameter,
  }) async {
    await _getAPIKey();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/auto-complete',
      parameters: {
        'q': searchParameter,
        'region': 'UK',
      },
      headers: {
        'x-rapidapi-host': url,
        'x-rapidapi-key': apiKey,
      },
      body: null,
    );
    final tickerList = await externalAPIProvider.getData();
    if (tickerList.runtimeType == int) {
      return "error";
    } else {
      tickerList["quotes"].forEach((element) {
        if (element["longname"] != null &&
            element["symbol"] != null &&
            element["exchange"] != null) {
          final TickerModel tickerModel = TickerModel(
            longName: element["longname"] as String,
            symbol: element["symbol"] as String,
            exchange: element["exchange"] as String,
          );
          tickers.add(tickerModel);
        }
      });
      return tickers;
    }
  }

  /// This method gets the current price of a specific investment based on its ticker symbol
  Future<Object> getPrice({
    required String tickerSymbol,
  }) async {
    await _getAPIKey();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/stock/v2/get-summary',
      parameters: {
        'symbol': tickerSymbol,
        'region': 'UK',
      },
      headers: {
        'x-rapidapi-host': url,
        'x-rapidapi-key': apiKey,
      },
      body: null,
    );
    final stockSummary = await externalAPIProvider.getData();
    if (stockSummary.runtimeType == int) {
      return "error";
    } else {
      final price = stockSummary["price"]["regularMarketPrice"]["raw"];
      return price.toString();
    }
  }
}
