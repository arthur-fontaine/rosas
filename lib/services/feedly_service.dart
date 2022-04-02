import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rosas/models/models_barrel.dart';

enum StreamContentRank { newest, oldest, engagement }

class Feedly {
  static const _baseUrl = 'cloud.feedly.com';

  static Future<Iterable<RosasSource>> searchSource(String searchTerm,
      {int count = 20, bool includeItems = false}) async {
    final searchFeedsResponse = await http.get(
      Uri.https(
        _baseUrl,
        '/v3/search/feeds',
        {'query': searchTerm, 'count': count.toString()},
      ),
    );

    final searchFeedData = json.decode(searchFeedsResponse.body);
    final searchFeedResults = searchFeedData['results'];

    if (searchFeedResults is List) {
      return searchFeedResults.map((result) {
        final topicsRaw = result['topics'];

        Iterable<RosasTopic> topics = [];

        if (topicsRaw is List) {
          topics = topicsRaw.map((topic) => RosasTopic(topic));
        }

        return RosasSource(RosasSourceFrom.feedly, result['feedId'],
            result['title'], topics, result['visualUrl'] ?? result['iconUrl'] ?? '');
      });
    }

    return [];
  }

  static Future<Iterable<RosasArticle>> getSourceArticles(RosasSource source,
      {int count = 20,
      StreamContentRank ranked = StreamContentRank.newest,
      DateTime? newerThan}) async {
    final streamContentResponse = await http.get(
      Uri.https(
        _baseUrl,
        '/v3/streams/contents',
        {
          'streamId': source.url,
          'count': count.toString(),
          'ranked': ranked.name,
          'newerThan':
              (newerThan ?? DateTime.now().subtract(const Duration(days: 31)))
                  .millisecondsSinceEpoch
                  .toString()
        },
      ),
    );

    final streamContentData = json.decode(streamContentResponse.body);
    final streamContentItems = streamContentData['items'];

    if (streamContentItems is List) {
      return (await Future.wait(streamContentItems.map((item) async {
        String? content;
        dynamic alternateHtml;

        if (item['alternate'] != null) {
          alternateHtml = item['alternate'].singleWhere(
              (alternate) => alternate['type'] == 'text/html',
              orElse: () => null);
        }

        if (item['content'] != null && item['content']['content'] != null) {
          content = item['content']['content'];
        } else if (alternateHtml != null) {
          content = (await http.get(Uri.parse(alternateHtml['href']))).body;
        }

        if (content != null) {
          return RosasArticle(
              item['title'] ?? '',
              item['canonicalUrl'] ?? '',
              item['published'] != null
                  ? DateTime.fromMillisecondsSinceEpoch(item['published'])
                  : DateTime.now(),
              source,
              content);
        }
      })))
          .whereType<RosasArticle>();
    }

    return [];
  }
}
