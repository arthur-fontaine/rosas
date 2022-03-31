import 'dart:convert';

class FeedlyFeedData {
  FeedlyFeedData({
    this.contentType,
    this.description,
    this.language,
    required this.id,
    required this.title,
    required this.feedId,
    this.topics,
    this.updated,
    this.website,
    this.subscribers,
    this.velocity,
    this.iconUrl,
    this.partial,
    this.coverUrl,
    this.visualUrl,
    this.estimatedEngagement,
    this.coverColor,
    this.state,
  });

  String? contentType;
  String? description;
  String? language;
  String id;
  String title;
  String feedId;
  List<String>? topics;
  int? updated;
  String? website;
  int? subscribers;
  double? velocity;
  String? iconUrl;
  bool? partial;
  String? coverUrl;
  String? visualUrl;
  int? estimatedEngagement;
  String? coverColor;
  String? state;

  factory FeedlyFeedData.fromJson(String str) => FeedlyFeedData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedlyFeedData.fromMap(Map<String, dynamic> json) => FeedlyFeedData(
    contentType: json["contentType"],
    description: json["description"],
    language: json["language"],
    id: json["id"],
    title: json["title"],
    feedId: json["feedId"],
    topics: json["topics"] == null ? null : List<String>.from(json["topics"].map((x) => x)),
    updated: json["updated"],
    website: json["website"],
    subscribers: json["subscribers"],
    velocity: json["velocity"] == null ? null : json["velocity"].toDouble(),
    iconUrl: json["iconUrl"],
    partial: json["partial"],
    coverUrl: json["coverUrl"],
    visualUrl: json["visualUrl"],
    estimatedEngagement: json["estimatedEngagement"],
    coverColor: json["coverColor"],
    state: json["state"],
  );

  Map<String, dynamic> toMap() => {
    "contentType": contentType,
    "description": description,
    "language": language,
    "id": id,
    "title": title,
    "feedId": feedId,
    "topics": topics == null ? null : List<dynamic>.from(topics!.map((x) => x)),
    "updated": updated,
    "website": website,
    "subscribers": subscribers,
    "velocity": velocity,
    "iconUrl": iconUrl,
    "partial": partial,
    "coverUrl": coverUrl,
    "visualUrl": visualUrl,
    "estimatedEngagement": estimatedEngagement,
    "coverColor": coverColor,
    "state": state,
  };
}
