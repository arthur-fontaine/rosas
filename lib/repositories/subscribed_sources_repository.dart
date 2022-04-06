import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/services_barrel.dart';

class SubscribedSourcesRepository {
  final List<RosasSource> _subscribedSources = [];
  final List<RosasArticle> _articles = [];

  SubscribedSourcesRepository();

  List<RosasSource> getSubscribedSources() => _subscribedSources;

  void subscribeSource(RosasSource source) async {
    if (!_subscribedSources.contains(source)) {
      _subscribedSources.add(source);

      if (auth.currentUser != null) {
        users.doc(auth.currentUser?.uid).update({
          "subscribedSources": FieldValue.arrayUnion([source.toJSON()])
        });
      }

      if (auth.currentUser == null || auth.currentUser!.isAnonymous) {
        LocalStorage.saveData(subscribedSources: _subscribedSources);
      }
    }
  }

  void unsubscribeSource(RosasSource source) {
    _subscribedSources.remove(source);

    if (auth.currentUser != null) {
      users.doc(auth.currentUser?.uid).update({
        "subscribedSources": FieldValue.arrayRemove([source.toJSON()])
      });
    }

    if (auth.currentUser == null || auth.currentUser!.isAnonymous) {
      LocalStorage.saveData(subscribedSources: _subscribedSources);
    }
  }

  List<RosasArticle> getArticles() => _articles;

  Future<void> fetchArticles() async {
    final newSources = await Future.wait(getSubscribedSources()
        .map((source) async => await source.fetchArticles()));

    _articles.removeWhere((element) => true);
    _articles.addAll(newSources
        .map((source) => source.articles)
        .expand((article) => article));
  }
}
