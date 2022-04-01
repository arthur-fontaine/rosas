import 'package:rosas/models/models_barrel.dart';

class SubscribedSourcesRepository {
  final List<RosasSource> _subscribedSources = [];

  SubscribedSourcesRepository();

  List<RosasSource> getSubscribedSources() => _subscribedSources;

  Future<void> subscribeSource(RosasSource source) async {
    if (!_subscribedSources.contains(source)) {
      _subscribedSources.add(await source.fetchArticles());
    }
  }

  void unsubscribeSource(RosasSource source) {
    _subscribedSources.remove(source);
  }

  void toggleSubscriptionSource(RosasSource source) {
    if (!_subscribedSources.contains(source)) {
      _subscribedSources.add(source);
    } else {
      _subscribedSources.remove(source);
    }
  }
}
