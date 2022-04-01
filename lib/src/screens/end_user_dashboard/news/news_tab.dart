import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        yahooFinanceProvider.getNewsArticles();
      },
      child: Center(
        child: SingleChildScrollView(
          child: FutureBuilder(
            future: yahooFinanceProvider.getNewsArticles(),
            builder: (context, snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data.runtimeType != String) {
                  // ignore: cast_nullable_to_non_nullable
                  articles = snapshot.data as List<ArticleModel>;
                  return ListView.builder(
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
                          trailing: const Icon(Icons.arrow_forward),
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
                  );
                } else {
                  return const Center(
                    child:
                        Text('An error was encountered, news was not fetched'),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
