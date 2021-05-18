import 'package:http/http.dart' as http;
import 'package:rosas/models/PapersResults.dart';
import 'package:rosas/models/PodcastsResults.dart';

// Future<List<FeedResult>> searchFeeds(String term) async {
//   final url = Uri.parse('https://rosasapi.herokuapp.com/feed?q=$term');
//   final response = await http.get(url);
//   List<FeedResult> body = feedResultsFromJson(response.body);

//   return body;
// }

class SearchFeeds {
  Future<PodcastsResults> podcasts(String term) async {
    final url =
        Uri.parse('https://itunes.apple.com/search?term=$term&media=podcast');
    final response = await http.get(url);
    return podcastsResultsFromJson(response.body);
  }

  Future<PapersResults> papers(String term) async {
    final url =
        Uri.parse('https://cloud.feedly.com/v3/search/feeds?query=$term');
    final response = await http.get(url);
    return papersResultsFromJson(response.body);
  }
}
