import 'package:flutter/foundation.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:http/http.dart' as http;
import 'package:rosas/services/services_barrel.dart';

Future<RssFeed> fetchFeed(String feedUrl) async {
  late final RssFeed feed;

  if (feedUrl.startsWith('feed/')) {
    final items = await Feedly.getStreamContent(feedUrl);
    feed = await Feedly.getFeed(feedUrl, items: items.toList());
  } else {
    final response = await http.get(Uri.parse(feedUrl));
    feed = RssFeed.parse(response.body
        .replaceFirst(RegExp(r'<link>.+</link>'), '<link>$feedUrl</link>'));
  }

  feed.items?.forEach((rssItem) => rssItem.sourceFeed = feed);

  return feed;
}
