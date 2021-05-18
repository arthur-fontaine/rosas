import 'dart:convert';

ParsedFeed parsedFeedFromJson(String str) =>
    ParsedFeed.fromJson(json.decode(str));

String parsedFeedToJson(ParsedFeed data) => json.encode(data.toJson());

class ParsedFeed {
  ParsedFeed({
    this.items,
    this.image,
    this.title,
    this.description,
    this.link,
    this.language,
    this.lastBuildDate,
    this.copyright,
    this.itunes,
  });

  final List<Item> items;
  final ParsedFeedImage image;
  final String title;
  final String description;
  final String link;
  final String language;
  final String lastBuildDate;
  final String copyright;
  final ParsedFeedItunes itunes;

  factory ParsedFeed.fromJson(Map<String, dynamic> json) => ParsedFeed(
        items: json["items"] == null
            ? null
            : List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        image: json["image"] == null
            ? null
            : ParsedFeedImage.fromJson(json["image"]),
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        link: json["link"] == null ? null : json["link"],
        language: json["language"] == null ? null : json["language"],
        lastBuildDate:
            json["lastBuildDate"] == null ? null : json["lastBuildDate"],
        copyright: json["copyright"] == null ? null : json["copyright"],
        itunes: json["itunes"] == null
            ? null
            : ParsedFeedItunes.fromJson(json["itunes"]),
      );

  Map<String, dynamic> toJson() => {
        "items": items == null
            ? null
            : List<dynamic>.from(items.map((x) => x.toJson())),
        "image": image == null ? null : image.toJson(),
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "link": link == null ? null : link,
        "language": language == null ? null : language,
        "lastBuildDate": lastBuildDate == null ? null : lastBuildDate,
        "copyright": copyright == null ? null : copyright,
        "itunes": itunes == null ? null : itunes.toJson(),
      };
}

class ParsedFeedImage {
  ParsedFeedImage({
    this.link,
    this.url,
    this.title,
  });

  final String link;
  final String url;
  final String title;

  factory ParsedFeedImage.fromJson(Map<String, dynamic> json) =>
      ParsedFeedImage(
        link: json["link"] == null ? null : json["link"],
        url: json["url"] == null ? null : json["url"],
        title: json["title"] == null ? null : json["title"],
      );

  Map<String, dynamic> toJson() => {
        "link": link == null ? null : link,
        "url": url == null ? null : url,
        "title": title == null ? null : title,
      };
}

class Item {
  Item({
    this.title,
    this.link,
    this.pubDate,
    this.enclosure,
    this.guid,
    this.isoDate,
    this.itunes,
    this.creator,
    this.contentEncoded,
    this.contentEncodedSnippet,
    this.dcCreator,
    this.comments,
    this.content,
    this.contentSnippet,
    this.categories,
  });

  final String title;
  final String link;
  final String pubDate;
  final Enclosure enclosure;
  final String guid;
  final DateTime isoDate;
  final ItemItunes itunes;
  final String creator;
  final String contentEncoded;
  final String contentEncodedSnippet;
  final String dcCreator;
  final String comments;
  final String content;
  final String contentSnippet;
  final List<String> categories;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: json["title"] == null ? null : json["title"],
        link: json["link"] == null ? null : json["link"],
        pubDate: json["pubDate"] == null ? null : json["pubDate"],
        enclosure: json["enclosure"] == null
            ? null
            : Enclosure.fromJson(json["enclosure"]),
        guid: json["guid"] == null ? null : json["guid"],
        isoDate:
            json["isoDate"] == null ? null : DateTime.parse(json["isoDate"]),
        itunes:
            json["itunes"] == null ? null : ItemItunes.fromJson(json["itunes"]),
        creator: json["creator"] == null ? null : json["creator"],
        contentEncoded:
            json["content:encoded"] == null ? null : json["content:encoded"],
        contentEncodedSnippet: json["content:encodedSnippet"] == null
            ? null
            : json["content:encodedSnippet"],
        dcCreator: json["dc:creator"] == null ? null : json["dc:creator"],
        comments: json["comments"] == null ? null : json["comments"],
        content: json["content"] == null ? null : json["content"],
        contentSnippet:
            json["contentSnippet"] == null ? null : json["contentSnippet"],
        categories: json["categories"] == null
            ? null
            : List<String>.from(json["categories"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "link": link == null ? null : link,
        "pubDate": pubDate == null ? null : pubDate,
        "enclosure": enclosure == null ? null : enclosure.toJson(),
        "guid": guid == null ? null : guid,
        "isoDate": isoDate == null ? null : isoDate.toIso8601String(),
        "itunes": itunes == null ? null : itunes.toJson(),
        "creator": creator == null ? null : creator,
        "content:encoded": contentEncoded == null ? null : contentEncoded,
        "content:encodedSnippet":
            contentEncodedSnippet == null ? null : contentEncodedSnippet,
        "dc:creator": dcCreator == null ? null : dcCreator,
        "comments": comments == null ? null : comments,
        "content": content == null ? null : content,
        "contentSnippet": contentSnippet == null ? null : contentSnippet,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x)),
      };
}

class Enclosure {
  Enclosure({
    this.url,
    this.type,
  });

  final String url;
  final String type;

  factory Enclosure.fromJson(Map<String, dynamic> json) => Enclosure(
        url: json["url"] == null ? null : json["url"],
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "type": type == null ? null : type,
      };
}

class ItemItunes {
  ItemItunes({
    this.author,
    this.subtitle,
    this.summary,
    this.duration,
    this.image,
  });

  final String author;
  final String subtitle;
  final String summary;
  final String duration;
  final String image;

  factory ItemItunes.fromJson(Map<String, dynamic> json) => ItemItunes(
        author: json["author"] == null ? null : json["author"],
        subtitle: json["subtitle"] == null ? null : json["subtitle"],
        summary: json["summary"] == null ? null : json["summary"],
        duration: json["duration"] == null ? null : json["duration"],
        image: json["image"] == null ? null : json["image"],
      );

  Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
        "subtitle": subtitle == null ? null : subtitle,
        "summary": summary == null ? null : summary,
        "duration": duration == null ? null : duration,
        "image": image == null ? null : image,
      };
}

class ParsedFeedItunes {
  ParsedFeedItunes({
    this.owner,
    this.image,
    this.categories,
    this.categoriesWithSubs,
    this.keywords,
    this.author,
    this.summary,
    this.explicit,
  });

  final Owner owner;
  final String image;
  final List<String> categories;
  final List<CategoriesWithSub> categoriesWithSubs;
  final List<String> keywords;
  final String author;
  final String summary;
  final String explicit;

  factory ParsedFeedItunes.fromJson(Map<String, dynamic> json) =>
      ParsedFeedItunes(
        owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
        image: json["image"] == null ? null : json["image"],
        categories: json["categories"] == null
            ? null
            : List<String>.from(json["categories"].map((x) => x)),
        categoriesWithSubs: json["categoriesWithSubs"] == null
            ? null
            : List<CategoriesWithSub>.from(json["categoriesWithSubs"]
                .map((x) => CategoriesWithSub.fromJson(x))),
        keywords: json["keywords"] == null
            ? null
            : List<String>.from(json["keywords"].map((x) => x)),
        author: json["author"] == null ? null : json["author"],
        summary: json["summary"] == null ? null : json["summary"],
        explicit: json["explicit"] == null ? null : json["explicit"],
      );

  Map<String, dynamic> toJson() => {
        "owner": owner == null ? null : owner.toJson(),
        "image": image == null ? null : image,
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x)),
        "categoriesWithSubs": categoriesWithSubs == null
            ? null
            : List<dynamic>.from(categoriesWithSubs.map((x) => x.toJson())),
        "keywords": keywords == null
            ? null
            : List<dynamic>.from(keywords.map((x) => x)),
        "author": author == null ? null : author,
        "summary": summary == null ? null : summary,
        "explicit": explicit == null ? null : explicit,
      };
}

class CategoriesWithSub {
  CategoriesWithSub({
    this.name,
    this.subs,
  });

  final String name;
  final List<Sub> subs;

  factory CategoriesWithSub.fromJson(Map<String, dynamic> json) =>
      CategoriesWithSub(
        name: json["name"] == null ? null : json["name"],
        subs: json["subs"] == null
            ? null
            : List<Sub>.from(json["subs"].map((x) => Sub.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "subs": subs == null
            ? null
            : List<dynamic>.from(subs.map((x) => x.toJson())),
      };
}

class Sub {
  Sub({
    this.name,
  });

  final String name;

  factory Sub.fromJson(Map<String, dynamic> json) => Sub(
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
      };
}

class Owner {
  Owner();

  factory Owner.fromJson(Map<String, dynamic> json) => Owner();

  Map<String, dynamic> toJson() => {};
}
