import 'package:rosas/models/models_barrel.dart';

class ReadLaterRepository {
  final List<RosasArticle> _articles = [];

  ReadLaterRepository();

  List<RosasArticle> getReadLaterArticles() => _articles;

  void addReadLaterArticle(RosasArticle article) {
    if (!_articles.contains(article)) {
      _articles.add(article);
    }
  }

  void removeReadLaterArticle(RosasArticle article) =>
      _articles.remove(article);

  void toggleReadLaterArticle(RosasArticle article) {
    if (!_articles.contains(article)) {
      _articles.add(article);
    } else {
      _articles.remove(article);
    }
  }
}
