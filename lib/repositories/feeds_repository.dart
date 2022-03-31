import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rosas/firebase/firebase_barrel.dart';
import 'package:rosas/utils/utils_barrel.dart';
import 'package:rosas/models/models_barrel.dart';

class FeedsRepository {
  FeedsRepository();

  Future<Iterable<String>> getSubscribedFeedUrls() async {
    return (await Future.wait(
            [_getLocalSubscribedFeedUrls(), _getRemoteSubscribedFeedUrls()]))
        .flatten();
  }

  Future<Iterable<RssFeed>> getSubscribedFeed() async {
    final subscribedFeedUrls = await getSubscribedFeedUrls();
    final feedToBeNotifiedUrls = await getFeedUrlsToBeNotified();

    final subscribedFeeds = await Future.wait(subscribedFeedUrls
        .map((subscribedFeedUrl) => fetchFeed(subscribedFeedUrl)));

    for (var subscribedFeed in subscribedFeeds) {
      subscribedFeed.subscribed = true;
      subscribedFeed.toBeNotified =
          feedToBeNotifiedUrls.contains(subscribedFeed.link);
    }

    return subscribedFeeds;
  }

  Future<Iterable<String>> _getLocalSubscribedFeedUrls() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('localSubscribedFeedUrls') ?? [];
  }

  Future<Iterable<String>> _getRemoteSubscribedFeedUrls() async {
    final user = auth.currentUser;

    if (user == null) return [];

    final remoteSubscribedFeedUrls =
        (await firestore.collection('users').doc(user.uid).get())
            .get('subscribedFeedUrls');

    if (remoteSubscribedFeedUrls is Iterable<String>) {
      return remoteSubscribedFeedUrls;
    } else {
      return [];
    }
  }

  // Future<Iterable<RssItem>> getSubscribedNews() async {
  //   final subscribedFeedUrls = await getSubscribedFeedUrls();
  //   final newsItems = await fetchNewsItems(subscribedFeedUrls);
  //   return newsItems;
  // }

  Future subscribeFeed(RssFeed feed) async {
    final feedUrl = feed.link;

    if (feedUrl == null) throw 'feed does not have link value.';

    final user = auth.currentUser;

    if (user != null) {
      firestore.collection('users').doc(user.uid).update({
        'data': FieldValue.arrayUnion([feedUrl])
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      final localSubscribedFeedUrls =
          prefs.getStringList('localSubscribedFeedUrls') ?? [];

      localSubscribedFeedUrls.add(feedUrl);

      prefs.setStringList(
          'localSubscribedFeedUrls', localSubscribedFeedUrls.toSet().toList());
    }

    feed.subscribed = true;
  }

  Future unsubscribeFeed(RssFeed feed) async {
    final feedUrl = feed.link;

    if (feedUrl == null) throw 'feed does not have link value.';

    final user = auth.currentUser;

    if (user != null) {
      firestore.collection('users').doc(user.uid).update({
        'data': FieldValue.arrayRemove([feedUrl])
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      final localSubscribedFeedUrls =
          prefs.getStringList('localSubscribedFeedUrls') ?? [];

      localSubscribedFeedUrls.remove(feedUrl);

      prefs.setStringList(
          'localSubscribedFeedUrls', localSubscribedFeedUrls.toSet().toList());
    }

    feed.subscribed = false;
  }

  Future<Iterable<String>> getFeedUrlsToBeNotified() async {
    return (await Future.wait([_getLocalFeedUrlsToBeNotified()])).flatten();
  }

  Future<Iterable<RssFeed>> getFeedsToBeNotified() async {
    final feedUrlsToBeNotified = await getFeedUrlsToBeNotified();

    final feedsToBeNotified = await Future.wait(feedUrlsToBeNotified
        .map((feedUrlToBeNotified) => fetchFeed(feedUrlToBeNotified)));

    return feedsToBeNotified;
  }

  Future<Iterable<RssItem>> getNotifications() async {
    final feedsToBeNotified = await getFeedsToBeNotified();

    return feedsToBeNotified
        .map((feed) => feed.items)
        .whereType<List<RssItem>>()
        .flatten();
  }

  Future<Iterable<String>> _getLocalFeedUrlsToBeNotified() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('localFeedUrlsToBeNotified') ?? [];
  }

  void addFeedTobeNotified(RssFeed feed) async {
    final feedUrl = feed.link;

    if (feedUrl == null) throw 'feed does not have link value.';

    final user = auth.currentUser;

    if (user != null) {
      firestore.collection('users').doc(user.uid).update({
        'data': FieldValue.arrayUnion([feedUrl])
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      final localFeedUrlsToBeNotified =
          prefs.getStringList('localFeedUrlsToBeNotified') ?? [];

      localFeedUrlsToBeNotified.add(feedUrl);

      prefs.setStringList('localFeedUrlsToBeNotified',
          localFeedUrlsToBeNotified.toSet().toList());
    }

    feed.toBeNotified = true;
  }

  void removeFeedTobeNotified(RssFeed feed) async {
    final feedUrl = feed.link;

    if (feedUrl == null) throw 'feed does not have link value.';

    final user = auth.currentUser;

    if (user != null) {
      firestore.collection('users').doc(user.uid).update({
        'data': FieldValue.arrayRemove([feedUrl])
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      final localFeedUrlsToBeNotified =
          prefs.getStringList('localFeedUrlsToBeNotified') ?? [];

      localFeedUrlsToBeNotified.remove(feedUrl);

      prefs.setStringList('localFeedUrlsToBeNotified',
          localFeedUrlsToBeNotified.toSet().toList());
    }

    feed.toBeNotified = false;
  }
}
