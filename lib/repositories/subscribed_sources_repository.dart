import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/services_barrel.dart';

class SubscribedSourcesRepository {
  final List<RosasSource> _subscribedSources = [];

  SubscribedSourcesRepository();

  List<RosasSource> getSubscribedSources() => _subscribedSources;

  Future<void> subscribeSource(RosasSource source) async {
    if (!_subscribedSources.contains(source)) {
      _subscribedSources.add(await source.fetchArticles());

      if (auth.currentUser != null) {
        users.doc(auth.currentUser?.uid).update({
          "subscribedSources": FieldValue.arrayUnion([source.toJSON()])
        });
      }
    }
  }

  Future<void> unsubscribeSource(RosasSource source) async {
    _subscribedSources.remove(source);

    if (auth.currentUser != null) {
      users.doc(auth.currentUser?.uid).update({
        "subscribedSources": FieldValue.arrayRemove([source.toJSON()])
      });
    }
  }
}
