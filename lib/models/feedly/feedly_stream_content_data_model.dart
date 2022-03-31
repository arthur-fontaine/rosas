import 'dart:convert';

class FeedlyStreamContentData {
  FeedlyStreamContentData({
    required this.id,
    this.title,
    this.direction,
    this.continuation,
    this.self,
    this.alternate,
    this.updated,
    this.items = const [],
  });

  String id;
  String? title;
  String? direction;
  String? continuation;
  List<Self>? self;
  List<Alternate>? alternate;
  int? updated;
  List<Item> items;

  factory FeedlyStreamContentData.fromJson(String str) => FeedlyStreamContentData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FeedlyStreamContentData.fromMap(Map<String, dynamic> json) => FeedlyStreamContentData(
    id: json["id"],
    title: json["title"],
    direction: json["direction"],
    continuation: json["continuation"],
    self: json["self"] == null ? null : List<Self>.from(json["self"].map((x) => Self.fromMap(x))),
    alternate: json["alternate"] == null ? null : List<Alternate>.from(json["alternate"].map((x) => Alternate.fromMap(x))),
    updated: json["updated"],
    items: List<Item>.from(json["items"].map((x) => Item.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "direction": direction,
    "continuation": continuation,
    "self": self == null ? null : List<dynamic>.from(self!.map((x) => x.toMap())),
    "alternate": alternate == null ? null : List<dynamic>.from(alternate!.map((x) => x.toMap())),
    "updated": updated,
    "items": List<dynamic>.from(items.map((x) => x.toMap())),
  };
}

class Alternate {
  Alternate({
    this.href,
    this.type,
  });

  String? href;
  String? type;

  factory Alternate.fromJson(String str) => Alternate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Alternate.fromMap(Map<String, dynamic> json) => Alternate(
    href: json["href"],
    type: json["type"],
  );

  Map<String, dynamic> toMap() => {
    "href": href,
    "type": type,
  };
}

class Item {
  Item({
    required this.id,
    this.unread,
    this.categories,
    this.tags,
    this.title,
    this.summary,
    required this.published,
    this.canonicalUrl,
    this.visual,
    this.updated,
    this.crawled,
    this.alternate,
    this.content,
    this.author,
    this.origin,
    this.engagement,
  });

  String id;
  bool? unread;
  List<Category>? categories;
  List<Category>? tags;
  String? title;
  Content? summary;
  String? canonicalUrl;
  Visual? visual;
  int published;
  int? updated;
  int? crawled;
  List<Alternate>? alternate;
  Content? content;
  String? author;
  Origin? origin;
  int? engagement;

  factory Item.fromJson(String str) => Item.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Item.fromMap(Map<String, dynamic> json) => Item(
    id: json["id"],
    unread: json["unread"],
    categories: json["categories"] == null ? null : List<Category>.from(json["categories"].map((x) => Category.fromMap(x))),
    tags: json["tags"] == null ? null : List<Category>.from(json["tags"].map((x) => Category.fromMap(x))),
    title: json["title"],
    canonicalUrl: json["canonicalUrl"],
    published: json["published"],
    updated: json["updated"],
    crawled: json["crawled"],
    alternate: json["alternate"] == null ? null : List<Alternate>.from(json["alternate"].map((x) => Alternate.fromMap(x))),
    content: json["content"] == null ? null : Content.fromMap(json["content"]),
    author: json["author"],
    summary: json["summary"] == null ? null : Content.fromMap(json["summary"]),
    visual: json["visual"] == null ? null : Visual.fromMap(json["visual"]),
    origin: json["origin"] == null ? null : Origin.fromMap(json["origin"]),
    engagement: json["engagement"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "unread": unread,
    "categories": categories == null ? null : List<dynamic>.from(categories!.map((x) => x.toMap())),
    "tags": tags == null ? null : List<dynamic>.from(tags!.map((x) => x.toMap())),
    "title": title,
    "published": published,
    "updated": updated,
    "crawled": crawled,
    "canonicalUrl": canonicalUrl,
    "alternate": alternate == null ? null : List<dynamic>.from(alternate!.map((x) => x.toMap())),
    "summary": summary?.toMap(),
    "visual": visual?.toMap(),
    "content": content?.toMap(),
    "author": author,
    "origin": origin?.toMap(),
    "engagement": engagement,
  };
}

class Category {
  Category({
    required this.id,
    required this.label,
  });

  String id;
  String label;

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
    id: json["id"],
    label: json["label"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "label": label,
  };
}

class Content {
  Content({
    this.direction,
    this.content,
  });

  String? direction;
  String? content;

  factory Content.fromJson(String str) => Content.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Content.fromMap(Map<String, dynamic> json) => Content(
    direction: json["direction"],
    content: json["content"],
  );

  Map<String, dynamic> toMap() => {
    "direction": direction,
    "content": content,
  };
}

class Origin {
  Origin({
    required this.streamId,
    required this.title,
    required this.htmlUrl,
  });

  String streamId;
  String title;
  String htmlUrl;

  factory Origin.fromJson(String str) => Origin.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Origin.fromMap(Map<String, dynamic> json) => Origin(
    streamId: json["streamId"],
    title: json["title"],
    htmlUrl: json["htmlUrl"],
  );

  Map<String, dynamic> toMap() => {
    "streamId": streamId,
    "title": title,
    "htmlUrl": htmlUrl,
  };
}

class Visual {
  Visual({
    this.contentType,
    this.processor,
    this.url,
    this.width,
    this.height,
  });

  String? contentType;
  String? processor;
  String? url;
  int? width;
  int? height;

  factory Visual.fromJson(String str) => Visual.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Visual.fromMap(Map<String, dynamic> json) => Visual(
    contentType: json["contentType"],
    processor: json["processor"],
    url: json["url"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toMap() => {
    "contentType": contentType,
    "processor": processor,
    "url": url,
    "width": width,
    "height": height,
  };
}

class Self {
  Self({
    this.href,
  });

  String? href;

  factory Self.fromJson(String str) => Self.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Self.fromMap(Map<String, dynamic> json) => Self(
    href: json[" href"],
  );

  Map<String, dynamic> toMap() => {
    " href": href,
  };
}
