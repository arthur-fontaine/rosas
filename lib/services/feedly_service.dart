import 'package:http/http.dart' as http;
import 'package:rosas/models/feedly/feedly_feed_data_model.dart';
import 'package:rosas/utils/utils_barrel.dart';
import 'package:rosas/models/models_barrel.dart';

enum StreamContentRank { newest, oldest, engagement }

class Feedly {
  static const _baseUrl = 'cloud.feedly.com';

  static Future<String> searchFeedsRaw(String searchTerm,
      {int count = 20}) async {
    final searchFeedsResponse = await http.get(
      Uri.https(
        _baseUrl,
        '/v3/search/feeds',
        {'query': searchTerm, 'count': count.toString()},
      ),
    );

    return searchFeedsResponse.body;
  }

  static Future<Iterable<RssFeed>> searchFeeds(String searchTerm,
      {int count = 20, bool includeItems = false}) async {
    final body = await searchFeedsRaw(searchTerm, count: count);
    final results = FeedlySearchFeedsData.fromJson(body).results;

    if (results.isEmpty) return [];

    Iterable<RssItem>? items;

    if (includeItems) {
      items = (await Future.wait(results.map((result) async {
        final feedItems = await getStreamContent(result.feedId);

        for (var feedItem in feedItems) {
          feedItem.sourceFeed = RssFeed(link: result.feedId);
        }

        return feedItems;
      })))
          .flatten();
    }

    return results.map((result) {
      final feed = RssFeed(
        title: result.title,
        description: result.description,
        link: result.feedId,
        dc: DublinCore(
          type: result.contentType,
          source: result.website,
        ),
        items: includeItems
            ? items!
                .where((item) => item.sourceFeed?.link == result.feedId)
                .toList()
            : null,
        image: RssImage(
          url: result.visualUrl ?? result.iconUrl ?? result.logo,
        ),
        categories:
            result.topics?.map((topic) => RssCategory(null, topic)).toList(),
        lastBuildDate: result.lastUpdated != null
            ? DateTime.fromMillisecondsSinceEpoch(result.lastUpdated!)
                .toIso8601String()
            : null,
        language: result.language,
        syndication: result.velocity != null
            ? Syndication(
                updateFrequency: result.velocity!.toInt(),
                updatePeriod: SyndicationUpdatePeriod.weekly,
              )
            : null,
      );

      if (feed.items != null) {
        for (var item in feed.items!) {
          item.sourceFeed = feed;
        }
      }

      return feed;
    });
  }

  static Future<String> getStreamContentRaw(String streamId,
      {int count = 20,
      StreamContentRank ranked = StreamContentRank.newest,
      DateTime? newerThan}) async {
    final searchFeedsResponse = await http.get(
      Uri.https(
        _baseUrl,
        '/v3/streams/contents',
        {
          'streamId': streamId,
          'count': count.toString(),
          'ranked': ranked.name,
          'newerThan': (newerThan ??
              DateTime.now().subtract(const Duration(days: 31))).millisecondsSinceEpoch.toString()
        },
      ),
    );

    return searchFeedsResponse.body;
  }

  static Future<Iterable<RssItem>> getStreamContent(String streamId,
      {int count = 20,
      StreamContentRank ranked = StreamContentRank.newest,
      DateTime? newerThan}) async {
    final body = await getStreamContentRaw(streamId,
        count: count, ranked: ranked, newerThan: newerThan);
    final streamContent = FeedlyStreamContentData.fromJson(body);

    return streamContent.items.map((item) => RssItem(
          title: item.title,
          description: item.content?.content,
          link: item.canonicalUrl ??
              item.alternate
                  ?.firstWhere((alternate) => alternate.type == 'text/html')
                  .href,
          categories: item.categories
              ?.map((category) => RssCategory(null, category.label))
              .toList(),
          guid: item.id,
          pubDate: DateTime.fromMillisecondsSinceEpoch(item.published),
          author: item.author,
          source: RssSource(item.origin?.htmlUrl, item.origin?.htmlUrl),
          content: item.content?.content != null
              ? RssContent(item.content!.content!, [])
              : null,
          enclosure:
              RssEnclosure(item.visual?.url, item.visual?.contentType, null),
          dc: DublinCore(
              title: item.title,
              created: DateTime.fromMillisecondsSinceEpoch(item.published),
              modified: item.updated != null
                  ? DateTime.fromMillisecondsSinceEpoch(item.updated!)
                  : null,
              contributor: item.author,
              publisher: item.origin?.title,
              source: item.origin?.htmlUrl),
        ));
  }

  static Future<String> getFeedRaw(String feedId) async {
    final searchFeedsResponse = await http.get(
      Uri.parse(Uri.https(_baseUrl, '/v3/feeds/').toString() +
          Uri.encodeComponent(feedId)),
    );

    return searchFeedsResponse.body;
  }

  static Future<RssFeed> getFeed(String feedId, {List<RssItem>? items}) async {
    final body = await getFeedRaw(feedId);
    final feedlyFeed = FeedlyFeedData.fromJson(body);

    final feed = RssFeed(
      title: feedlyFeed.title,
      description: feedlyFeed.description,
      link: feedlyFeed.feedId,
      dc: DublinCore(
        type: feedlyFeed.contentType,
        source: feedlyFeed.website,
      ),
      items: items,
      image: RssImage(
        url: feedlyFeed.visualUrl ?? feedlyFeed.iconUrl,
      ),
      categories:
          feedlyFeed.topics?.map((topic) => RssCategory(null, topic)).toList(),
      lastBuildDate: feedlyFeed.updated != null
          ? DateTime.fromMillisecondsSinceEpoch(feedlyFeed.updated!)
              .toIso8601String()
          : null,
      language: feedlyFeed.language,
      syndication: feedlyFeed.velocity != null
          ? Syndication(
              updateFrequency: feedlyFeed.velocity!.toInt(),
              updatePeriod: SyndicationUpdatePeriod.weekly,
            )
          : null,
    );

    feed.color = feedlyFeed.coverColor;

    return feed;
  }
}
