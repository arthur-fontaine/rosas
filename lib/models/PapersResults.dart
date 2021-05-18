// To parse this JSON data, do
//
//     final papersResults = papersResultsFromJson(jsonString);

import 'dart:convert';

PapersResults papersResultsFromJson(String str) =>
    PapersResults.fromJson(json.decode(str));

String papersResultsToJson(PapersResults data) => json.encode(data.toJson());

class PapersResults {
  PapersResults({
    this.hint,
    this.results,
    this.related,
  });

  final String hint;
  final List<PaperResult> results;
  final List<String> related;

  factory PapersResults.fromJson(Map<String, dynamic> json) => PapersResults(
        hint: json["hint"] == null ? null : json["hint"],
        results: json["results"] == null
            ? null
            : List<PaperResult>.from(
                json["results"].map((x) => PaperResult.fromJson(x))),
        related: json["related"] == null
            ? null
            : List<String>.from(json["related"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "hint": hint == null ? null : hint,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
        "related":
            related == null ? null : List<dynamic>.from(related.map((x) => x)),
      };
}

class PaperResult {
  PaperResult({
    this.title,
    this.website,
    this.feedId,
    this.lastUpdated,
    this.velocity,
    this.subscribers,
    this.curated,
    this.featured,
    this.contentType,
    this.language,
    this.description,
    this.iconUrl,
    this.visualUrl,
    this.partial,
    this.coverColor,
    this.deliciousTags,
    this.coverUrl,
    this.logo,
  });

  final String title;
  final String website;
  final String feedId;
  final int lastUpdated;
  final double velocity;
  final int subscribers;
  final bool curated;
  final bool featured;
  final String contentType;
  final String language;
  final String description;
  final String iconUrl;
  final String visualUrl;
  final bool partial;
  final String coverColor;
  final List<String> deliciousTags;
  final String coverUrl;
  final String logo;

  factory PaperResult.fromJson(Map<String, dynamic> json) => PaperResult(
        title: json["title"] == null ? null : json["title"],
        website: json["website"] == null ? null : json["website"],
        feedId: json["feedId"] == null ? null : json["feedId"],
        lastUpdated: json["lastUpdated"] == null ? null : json["lastUpdated"],
        velocity: json["velocity"] == null ? null : json["velocity"].toDouble(),
        subscribers: json["subscribers"] == null ? null : json["subscribers"],
        curated: json["curated"] == null ? null : json["curated"],
        featured: json["featured"] == null ? null : json["featured"],
        contentType: json["contentType"] == null ? null : json["contentType"],
        language: json["language"] == null ? null : json["language"],
        description: json["description"] == null ? null : json["description"],
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        visualUrl: json["visualUrl"] == null ? null : json["visualUrl"],
        partial: json["partial"] == null ? null : json["partial"],
        coverColor: json["coverColor"] == null ? null : json["coverColor"],
        deliciousTags: json["deliciousTags"] == null
            ? null
            : List<String>.from(json["deliciousTags"].map((x) => x)),
        coverUrl: json["coverUrl"] == null ? null : json["coverUrl"],
        logo: json["logo"] == null ? null : json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "website": website == null ? null : website,
        "feedId": feedId == null ? null : feedId,
        "lastUpdated": lastUpdated == null ? null : lastUpdated,
        "velocity": velocity == null ? null : velocity,
        "subscribers": subscribers == null ? null : subscribers,
        "curated": curated == null ? null : curated,
        "featured": featured == null ? null : featured,
        "contentType": contentType == null ? null : contentType,
        "language": language == null ? null : language,
        "description": description == null ? null : description,
        "iconUrl": iconUrl == null ? null : iconUrl,
        "visualUrl": visualUrl == null ? null : visualUrl,
        "partial": partial == null ? null : partial,
        "coverColor": coverColor == null ? null : coverColor,
        "deliciousTags": deliciousTags == null
            ? null
            : List<dynamic>.from(deliciousTags.map((x) => x)),
        "coverUrl": coverUrl == null ? null : coverUrl,
        "logo": logo == null ? null : logo,
      };
}
