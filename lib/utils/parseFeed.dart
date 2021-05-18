import 'package:http/http.dart' as http;
import 'package:rosas/models/PaperFeed.dart';
import 'package:webfeed/webfeed.dart';

// Future<List<ParsedFeed>> parseFeeds(List<String> feeds) async {
//   List<ParsedFeed> parsedFeeds = [];

//   for (var feed in feeds) {
//     final url =
//         Uri.parse('https://rosasapi.herokuapp.com/feed/parse?url=$feed');
//     final response = await http.get(url);
//     ParsedFeed body = parsedFeedFromJson(response.body);

//     parsedFeeds.add(body);
//   }

//   return parsedFeeds;
// }

class ParseFeed {
  Future<PaperFeed> paper(String feedId) async {
    final url = Uri.parse(
        'https://cloud.feedly.com/v3/streams/${Uri.encodeComponent(feedId)}/contents');
    final response = await http.get(url);
    return paperFeedFromJson(response.body);
  }

  Future<RssFeed> podcast(String feedUrl) async {
    final url = Uri.parse(feedUrl);
    final response = await http.get(url);

    return RssFeed.parse(response.body);
  }
}
