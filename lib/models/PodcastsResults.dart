// To parse this JSON data, do
//
//     final podcastsResults = podcastsResultsFromJson(jsonString);

import 'dart:convert';

PodcastsResults podcastsResultsFromJson(String str) =>
    PodcastsResults.fromJson(json.decode(str));

String podcastsResultsToJson(PodcastsResults data) =>
    json.encode(data.toJson());

class PodcastsResults {
  PodcastsResults({
    this.resultCount,
    this.results,
  });

  final int resultCount;
  final List<PodcastResult> results;

  factory PodcastsResults.fromJson(Map<String, dynamic> json) =>
      PodcastsResults(
        resultCount: json["resultCount"] == null ? null : json["resultCount"],
        results: json["results"] == null
            ? null
            : List<PodcastResult>.from(
                json["results"].map((x) => PodcastResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resultCount": resultCount == null ? null : resultCount,
        "results": results == null
            ? null
            : List<dynamic>.from(results.map((x) => x.toJson())),
      };
}

class PodcastResult {
  PodcastResult({
    this.wrapperType,
    this.kind,
    this.collectionId,
    this.trackId,
    this.artistName,
    this.collectionName,
    this.trackName,
    this.collectionCensoredName,
    this.trackCensoredName,
    this.collectionViewUrl,
    this.feedUrl,
    this.trackViewUrl,
    this.artworkUrl30,
    this.artworkUrl60,
    this.artworkUrl100,
    this.collectionPrice,
    this.trackPrice,
    this.trackRentalPrice,
    this.collectionHdPrice,
    this.trackHdPrice,
    this.trackHdRentalPrice,
    this.releaseDate,
    this.collectionExplicitness,
    this.trackExplicitness,
    this.trackCount,
    this.country,
    this.currency,
    this.primaryGenreName,
    this.contentAdvisoryRating,
    this.artworkUrl600,
    this.genreIds,
    this.genres,
    this.artistId,
    this.artistViewUrl,
  });

  final String wrapperType;
  final String kind;
  final int collectionId;
  final int trackId;
  final String artistName;
  final String collectionName;
  final String trackName;
  final String collectionCensoredName;
  final String trackCensoredName;
  final String collectionViewUrl;
  final String feedUrl;
  final String trackViewUrl;
  final String artworkUrl30;
  final String artworkUrl60;
  final String artworkUrl100;
  final double collectionPrice;
  final double trackPrice;
  final int trackRentalPrice;
  final int collectionHdPrice;
  final int trackHdPrice;
  final int trackHdRentalPrice;
  final DateTime releaseDate;
  final String collectionExplicitness;
  final String trackExplicitness;
  final int trackCount;
  final String country;
  final String currency;
  final String primaryGenreName;
  final String contentAdvisoryRating;
  final String artworkUrl600;
  final List<String> genreIds;
  final List<String> genres;
  final int artistId;
  final String artistViewUrl;

  factory PodcastResult.fromJson(Map<String, dynamic> json) => PodcastResult(
        wrapperType: json["wrapperType"] == null ? null : json["wrapperType"],
        kind: json["kind"] == null ? null : json["kind"],
        collectionId:
            json["collectionId"] == null ? null : json["collectionId"],
        trackId: json["trackId"] == null ? null : json["trackId"],
        artistName: json["artistName"] == null ? null : json["artistName"],
        collectionName:
            json["collectionName"] == null ? null : json["collectionName"],
        trackName: json["trackName"] == null ? null : json["trackName"],
        collectionCensoredName: json["collectionCensoredName"] == null
            ? null
            : json["collectionCensoredName"],
        trackCensoredName: json["trackCensoredName"] == null
            ? null
            : json["trackCensoredName"],
        collectionViewUrl: json["collectionViewUrl"] == null
            ? null
            : json["collectionViewUrl"],
        feedUrl: json["feedUrl"] == null ? null : json["feedUrl"],
        trackViewUrl:
            json["trackViewUrl"] == null ? null : json["trackViewUrl"],
        artworkUrl30:
            json["artworkUrl30"] == null ? null : json["artworkUrl30"],
        artworkUrl60:
            json["artworkUrl60"] == null ? null : json["artworkUrl60"],
        artworkUrl100:
            json["artworkUrl100"] == null ? null : json["artworkUrl100"],
        collectionPrice:
            json["collectionPrice"] == null ? null : json["collectionPrice"],
        trackPrice: json["trackPrice"] == null ? null : json["trackPrice"],
        trackRentalPrice:
            json["trackRentalPrice"] == null ? null : json["trackRentalPrice"],
        collectionHdPrice: json["collectionHdPrice"] == null
            ? null
            : json["collectionHdPrice"],
        trackHdPrice:
            json["trackHdPrice"] == null ? null : json["trackHdPrice"],
        trackHdRentalPrice: json["trackHdRentalPrice"] == null
            ? null
            : json["trackHdRentalPrice"],
        releaseDate: json["releaseDate"] == null
            ? null
            : DateTime.parse(json["releaseDate"]),
        collectionExplicitness: json["collectionExplicitness"] == null
            ? null
            : json["collectionExplicitness"],
        trackExplicitness: json["trackExplicitness"] == null
            ? null
            : json["trackExplicitness"],
        trackCount: json["trackCount"] == null ? null : json["trackCount"],
        country: json["country"] == null ? null : json["country"],
        currency: json["currency"] == null ? null : json["currency"],
        primaryGenreName:
            json["primaryGenreName"] == null ? null : json["primaryGenreName"],
        contentAdvisoryRating: json["contentAdvisoryRating"] == null
            ? null
            : json["contentAdvisoryRating"],
        artworkUrl600:
            json["artworkUrl600"] == null ? null : json["artworkUrl600"],
        genreIds: json["genreIds"] == null
            ? null
            : List<String>.from(json["genreIds"].map((x) => x)),
        genres: json["genres"] == null
            ? null
            : List<String>.from(json["genres"].map((x) => x)),
        artistId: json["artistId"] == null ? null : json["artistId"],
        artistViewUrl:
            json["artistViewUrl"] == null ? null : json["artistViewUrl"],
      );

  Map<String, dynamic> toJson() => {
        "wrapperType": wrapperType == null ? null : wrapperType,
        "kind": kind == null ? null : kind,
        "collectionId": collectionId == null ? null : collectionId,
        "trackId": trackId == null ? null : trackId,
        "artistName": artistName == null ? null : artistName,
        "collectionName": collectionName == null ? null : collectionName,
        "trackName": trackName == null ? null : trackName,
        "collectionCensoredName":
            collectionCensoredName == null ? null : collectionCensoredName,
        "trackCensoredName":
            trackCensoredName == null ? null : trackCensoredName,
        "collectionViewUrl":
            collectionViewUrl == null ? null : collectionViewUrl,
        "feedUrl": feedUrl == null ? null : feedUrl,
        "trackViewUrl": trackViewUrl == null ? null : trackViewUrl,
        "artworkUrl30": artworkUrl30 == null ? null : artworkUrl30,
        "artworkUrl60": artworkUrl60 == null ? null : artworkUrl60,
        "artworkUrl100": artworkUrl100 == null ? null : artworkUrl100,
        "collectionPrice": collectionPrice == null ? null : collectionPrice,
        "trackPrice": trackPrice == null ? null : trackPrice,
        "trackRentalPrice": trackRentalPrice == null ? null : trackRentalPrice,
        "collectionHdPrice":
            collectionHdPrice == null ? null : collectionHdPrice,
        "trackHdPrice": trackHdPrice == null ? null : trackHdPrice,
        "trackHdRentalPrice":
            trackHdRentalPrice == null ? null : trackHdRentalPrice,
        "releaseDate":
            releaseDate == null ? null : releaseDate.toIso8601String(),
        "collectionExplicitness":
            collectionExplicitness == null ? null : collectionExplicitness,
        "trackExplicitness":
            trackExplicitness == null ? null : trackExplicitness,
        "trackCount": trackCount == null ? null : trackCount,
        "country": country == null ? null : country,
        "currency": currency == null ? null : currency,
        "primaryGenreName": primaryGenreName == null ? null : primaryGenreName,
        "contentAdvisoryRating":
            contentAdvisoryRating == null ? null : contentAdvisoryRating,
        "artworkUrl600": artworkUrl600 == null ? null : artworkUrl600,
        "genreIds": genreIds == null
            ? null
            : List<dynamic>.from(genreIds.map((x) => x)),
        "genres":
            genres == null ? null : List<dynamic>.from(genres.map((x) => x)),
        "artistId": artistId == null ? null : artistId,
        "artistViewUrl": artistViewUrl == null ? null : artistViewUrl,
      };
}
