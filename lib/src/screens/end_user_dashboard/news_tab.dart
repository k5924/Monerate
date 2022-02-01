import 'package:flutter/material.dart';
import 'package:monerate/src/models/export.dart';
import 'package:monerate/src/screens/end_user_dashboard/export.dart';

class NewsTab extends StatefulWidget {
  final List<ArticleModel> articles;
  const NewsTab({Key? key, required this.articles}) : super(key: key);

  @override
  _NewsTabState createState() => _NewsTabState();
}

class _NewsTabState extends State<NewsTab> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: widget.articles.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: ListTile(
                leading: Image.network(widget.articles[index].thumbnailURL),
                title: Text(
                  widget.articles[index].title,
                ),
                subtitle: Text(widget.articles[index].provider),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsArticleScreen(url: widget.articles[index].url),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
