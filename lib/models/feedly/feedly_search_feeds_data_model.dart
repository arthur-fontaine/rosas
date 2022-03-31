import 'dart:convert';

class FeedlySearchFeedsData {
  FeedlySearchFeedsData({
    required this.results,
    required this.hint,
    required this.related,
  });

  String hint;
  List<FeedlySearchFeedsResult> results;
  List<String> related;

  factory FeedlySearchFeedsData.fromJson(String str) =>
      FeedlySearchFeedsData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedlySearchFeedsData.fromMap(Map<String, dynamic> json) =>
      FeedlySearchFeedsData(
        hint: json["hint"] ?? '',
        results: json["results"] == null
            ? []
            : List<FeedlySearchFeedsResult>.from(
                json["results"].map((x) => FeedlySearchFeedsResult.fromMap(x))),
        related: json["related"] == null
            ? []
            : List<String>.from(json["related"].map((x) => x)),
      );

  Map<String, dynamic> toMap() => {
        "hint": hint,
        "results": results,
        "related": related,
      };
}

class FeedlySearchFeedsResult {
  FeedlySearchFeedsResult({
    required this.title,
    this.website,
    required this.feedId,
    this.lastUpdated,
    this.velocity,
    required this.subscribers,
    this.curated,
    this.featured,
    this.contentType,
    this.language,
    this.description,
    this.iconUrl,
    this.visualUrl,
    this.partial,
    this.coverColor,
    this.topics,
    this.coverUrl,
    this.logo,
  });

  String title;
  String? website;
  String feedId;
  int? lastUpdated;
  double? velocity;
  int subscribers;
  bool? curated;
  bool? featured;
  String? contentType;
  String? language;
  String? description;
  String? iconUrl;
  String? visualUrl;
  bool? partial;
  String? coverColor;
  List<String>? topics;
  String? coverUrl;
  String? logo;

  factory FeedlySearchFeedsResult.fromJson(String str) =>
      FeedlySearchFeedsResult.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedlySearchFeedsResult.fromMap(Map<String, dynamic> json) =>
      FeedlySearchFeedsResult(
        title: json["title"],
        website: json["website"],
        feedId: json["feedId"],
        lastUpdated: json["lastUpdated"],
        velocity: json["velocity"],
        subscribers: json["subscribers"],
        curated: json["curated"],
        featured: json["featured"],
        contentType: json["contentType"],
        language: json["language"],
        description: json["description"],
        iconUrl: json["iconUrl"],
        visualUrl: json["visualUrl"],
        partial: json["partial"],
        coverColor: json["coverColor"],
        topics: json["topics"] == null
            ? null
            : List<String>.from(json["topics"].map((x) => x)),
        coverUrl: json["coverUrl"],
        logo: json["logo"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "website": website,
        "feedId": feedId,
        "lastUpdated": lastUpdated,
        "velocity": velocity,
        "subscribers": subscribers,
        "curated": curated,
        "featured": featured,
        "contentType": contentType,
        "language": language,
        "description": description,
        "iconUrl": iconUrl,
        "visualUrl": visualUrl,
        "partial": partial,
        "coverColor": coverColor,
        "topics": topics,
        "coverUrl": coverUrl,
        "logo": logo,
      };
}
