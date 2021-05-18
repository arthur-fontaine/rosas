// To parse this JSON data, do
//
//     final paperFeed = paperFeedFromJson(jsonString);

import 'dart:convert';

PaperFeed paperFeedFromJson(String str) => PaperFeed.fromJson(json.decode(str));

String paperFeedToJson(PaperFeed data) => json.encode(data.toJson());

class PaperFeed {
  String id;
  String title;
  int updated;
  String direction;
  String continuation;
  List<Alternate> alternate;
  List<PaperItem> items;

  PaperFeed(
      {this.id,
      this.title,
      this.updated,
      this.direction,
      this.continuation,
      this.alternate,
      this.items});

  PaperFeed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    updated = json['updated'];
    direction = json['direction'];
    continuation = json['continuation'];
    if (json['alternate'] != null) {
      alternate = new List<Alternate>();
      json['alternate'].forEach((v) {
        alternate.add(new Alternate.fromJson(v));
      });
    }
    if (json['items'] != null) {
      items = new List<PaperItem>();
      json['items'].forEach((v) {
        items.add(new PaperItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['updated'] = this.updated;
    data['direction'] = this.direction;
    data['continuation'] = this.continuation;
    if (this.alternate != null) {
      data['alternate'] = this.alternate.map((v) => v.toJson()).toList();
    }
    if (this.items != null) {
      data['items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Alternate {
  String href;
  String type;

  Alternate({this.href, this.type});

  Alternate.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['type'] = this.type;
    return data;
  }
}

class PaperItem {
  String id;
  List<String> keywords;
  String originId;
  String fingerprint;
  Content content;
  String title;
  int updated;
  String author;
  int crawled;
  Origin origin;
  int published;
  List<Canonical> canonical;
  Content summary;
  List<Alternate> alternate;
  Visual visual;
  bool unread;
  int engagement;
  double engagementRate;
  int recrawled;
  int updateCount;

  PaperItem(
      {this.id,
      this.keywords,
      this.originId,
      this.fingerprint,
      this.content,
      this.title,
      this.updated,
      this.author,
      this.crawled,
      this.origin,
      this.published,
      this.canonical,
      this.summary,
      this.alternate,
      this.visual,
      this.unread,
      this.engagement,
      this.engagementRate,
      this.recrawled,
      this.updateCount});

  PaperItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    keywords = json['keywords'].cast<String>();
    originId = json['originId'];
    fingerprint = json['fingerprint'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    title = json['title'];
    updated = json['updated'];
    author = json['author'];
    crawled = json['crawled'];
    origin =
        json['origin'] != null ? new Origin.fromJson(json['origin']) : null;
    published = json['published'];
    if (json['canonical'] != null) {
      canonical = new List<Canonical>();
      json['canonical'].forEach((v) {
        canonical.add(new Canonical.fromJson(v));
      });
    }
    summary =
        json['summary'] != null ? new Content.fromJson(json['summary']) : null;
    if (json['alternate'] != null) {
      alternate = new List<Alternate>();
      json['alternate'].forEach((v) {
        alternate.add(new Alternate.fromJson(v));
      });
    }
    visual =
        json['visual'] != null ? new Visual.fromJson(json['visual']) : null;
    unread = json['unread'];
    engagement = json['engagement'];
    engagementRate = json['engagementRate'];
    recrawled = json['recrawled'];
    updateCount = json['updateCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['keywords'] = this.keywords;
    data['originId'] = this.originId;
    data['fingerprint'] = this.fingerprint;
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['title'] = this.title;
    data['updated'] = this.updated;
    data['author'] = this.author;
    data['crawled'] = this.crawled;
    if (this.origin != null) {
      data['origin'] = this.origin.toJson();
    }
    data['published'] = this.published;
    if (this.canonical != null) {
      data['canonical'] = this.canonical.map((v) => v.toJson()).toList();
    }
    if (this.summary != null) {
      data['summary'] = this.summary.toJson();
    }
    if (this.alternate != null) {
      data['alternate'] = this.alternate.map((v) => v.toJson()).toList();
    }
    if (this.visual != null) {
      data['visual'] = this.visual.toJson();
    }
    data['unread'] = this.unread;
    data['engagement'] = this.engagement;
    data['engagementRate'] = this.engagementRate;
    data['recrawled'] = this.recrawled;
    data['updateCount'] = this.updateCount;
    return data;
  }
}

class Content {
  String content;
  String direction;

  Content({this.content, this.direction});

  Content.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    direction = json['direction'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['direction'] = this.direction;
    return data;
  }
}

class Origin {
  String streamId;
  String title;
  String htmlUrl;

  Origin({this.streamId, this.title, this.htmlUrl});

  Origin.fromJson(Map<String, dynamic> json) {
    streamId = json['streamId'];
    title = json['title'];
    htmlUrl = json['htmlUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['streamId'] = this.streamId;
    data['title'] = this.title;
    data['htmlUrl'] = this.htmlUrl;
    return data;
  }
}

class Canonical {
  String title;
  String href;
  String type;

  Canonical({this.title, this.href, this.type});

  Canonical.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    href = json['href'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['href'] = this.href;
    data['type'] = this.type;
    return data;
  }
}

class Visual {
  String url;
  int width;
  int height;
  String processor;
  String contentType;

  Visual({this.url, this.width, this.height, this.processor, this.contentType});

  Visual.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
    processor = json['processor'];
    contentType = json['contentType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    data['processor'] = this.processor;
    data['contentType'] = this.contentType;
    return data;
  }
}
