// ignore_for_file: avoid_dynamic_calls

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';

class YahooFinanceProvider {
  final RemoteConfigProvider remoteConfigProvider =
      RemoteConfigProvider(remoteConfig: FirebaseRemoteConfig.instance);
  final String url = "yh-finance.p.rapidapi.com";

  late String apiKey;

  List<ArticleModel> news = [];
  List<TickerModel> tickers = [];

  YahooFinanceProvider() {
    getAPIKey();
  }

  Future<void> getAPIKey() async {
    apiKey = await remoteConfigProvider.getYahooFinanceAPIKey();
  }

  Future<Object> getNewsArticles() async {
    await getAPIKey();
    final ExternalAPIProvider externalAPIProvider = ExternalAPIProvider(
      url: url,
      endPoint: '/news/v2/list',
      parameters: null,
      headers: {
        'content-type': 'text/plain',
        'x-rapidapi-host': url,
        'x-rapidapi-key': apiKey,
      },
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

  Future<Object> getTickerSymbol(String searchParameter) async {
    await getAPIKey();
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

  Future<Object> getPrice(String tickerSymbol) async {
    await getAPIKey();
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
