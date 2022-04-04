import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/firebase/auth_service.dart';
import 'package:rosas/services/firebase/firestore_service.dart';

class ReadLaterRepository {
  final List<RosasArticle> _articles = [];

  ReadLaterRepository();

  List<RosasArticle> getReadLaterArticles() => _articles;

  void addReadLaterArticle(RosasArticle article) {
    if (!_articles.contains(article)) {
      _articles.add(article);

      if (auth.currentUser != null) {
        users.doc(auth.currentUser?.uid).update({
          "readLater": FieldValue.arrayUnion([article.toJSON()])
        });
      }
    }
  }

  void removeReadLaterArticle(RosasArticle article) {
    _articles.remove(article);

    if (auth.currentUser != null) {
      users.doc(auth.currentUser?.uid).update({
        "readLater": FieldValue.arrayRemove([article.toJSON()])
      });
    }
  }

  void toggleReadLaterArticle(RosasArticle article) {
    if (!_articles.contains(article)) {
      addReadLaterArticle(article);
    } else {
      removeReadLaterArticle(article);
    }
  }
}
