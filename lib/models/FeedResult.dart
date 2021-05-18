import 'dart:convert';

List<FeedResult> feedResultsFromJson(String str) =>
    List<FeedResult>.from(json.decode(str).map((x) => FeedResult.fromJson(x)));

String feedResultsToJson(List<FeedResult> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedResult {
  FeedResult({
    this.title,
    this.feedUrl,
    this.iconUrl,
    this.website,
    this.lastUpdated,
    this.author,
    this.type,
  });

  final String title;
  final String feedUrl;
  final String iconUrl;
  final String website;
  final DateTime lastUpdated;
  final String author;
  final String type;

  factory FeedResult.fromJson(Map<String, dynamic> json) => FeedResult(
        title: json["title"] == null ? null : json["title"],
        feedUrl: json["feedUrl"] == null ? null : json["feedUrl"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        website: json["website"] == null ? null : json["website"],
        lastUpdated: json["lastUpdated"] == null
            ? null
            : DateTime.parse(json["lastUpdated"]),
        author: json["author"] == null ? null : json["author"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "feedUrl": feedUrl == null ? null : feedUrl,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "website": website == null ? null : website,
        "lastUpdated":
            lastUpdated == null ? null : lastUpdated.toIso8601String(),
        "author": author == null ? null : author,
        "type": type == null ? null : type,
      };
}
