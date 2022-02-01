import 'package:flutter_test/flutter_test.dart';
import 'package:monerate/src/models/article_model.dart';

void main() {
  group('Article Model:', () {
    final ArticleModel articleModel = ArticleModel(
      title: 'this is the title',
      thumbnailURL: 'https://google.com',
      provider: 'financial times',
      url: 'https://financialtimes.com',
    );
    test('Calling title on article object returns associated title', () {
      expect(
        articleModel.title,
        'this is the title',
      );
    });

    test('Calling thumbnail url on article object returns associated thumbnail url', () {
      expect(
        articleModel.thumbnailURL,
        'https://google.com',
      );
    });

    test('Calling provider on article object returns associated provider', () {
      expect(
        articleModel.provider,
        'financial times',
      );
    });

    test('Calling url on article object returns associated url', () {
      expect(
        articleModel.url,
        'https://financialtimes.com',
      );
    });
  });
}
