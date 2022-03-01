import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/providers/export.dart';
import 'package:monerate/src/screens/end_user_dashboard/export.dart';

class NewsTab extends StatefulWidget {
  const NewsTab({Key? key}) : super(key: key);

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  late List<ArticleModel> articles = <ArticleModel>[];
  final YahooFinanceProvider yahooFinanceProvider = YahooFinanceProvider();

  @override
  void initState() {
    super.initState();
    _getNews();
  }

  Future<void> _getNews() async {
    EasyLoading.show(status: 'loading...');
    final result = await yahooFinanceProvider.getNewsArticles();
    if (result.runtimeType == String) {
      EasyLoading.showError(
        "An error was encountered, news has not been fetched",
      );
    } else {
      if (mounted) {
        setState(() {
          articles = result as List<ArticleModel>;
          EasyLoading.dismiss();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        articles.clear();
        await _getNews();
      },
      child: SingleChildScrollView(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: ListTile(
                leading: Image.network(articles[index].thumbnailURL),
                title: Text(
                  articles[index].title,
                ),
                subtitle: Text(articles[index].provider),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsArticleScreen(url: articles[index].url),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
