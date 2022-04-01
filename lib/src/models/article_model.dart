/// This class structures how articles will be retrieved
class ArticleModel {
  /// This variable will store the title of each article
  final String title;

  /// This variable will store the url to the image for an article
  final String thumbnailURL;

  /// This variable will store the provider of each article
  final String provider;

  /// This variable will store the url to the article
  final String url;

  /// This constructor requires that all fields be populated on initialization
  ArticleModel({
    required this.title,
    required this.thumbnailURL,
    required this.provider,
    required this.url,
  });
}
