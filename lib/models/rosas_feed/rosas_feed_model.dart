import 'package:webfeed/webfeed.dart';

extension RosasFeedX on RssFeed {
  static final Map<String, bool?> _subscribedMap = {};
  static final Map<String, bool?> _toBeNotifiedMap = {};
  static final Map<String, String?> _colorMap = {};
  static final Map<String, List<RssItem>?> _itemsMap = {};

  bool? get subscribed => _subscribedMap[link];
  set subscribed(bool? value) => link != null ? _subscribedMap[link!] = value : null;

  bool? get toBeNotified => _toBeNotifiedMap[link];
  set toBeNotified(bool? value) => link != null ? _toBeNotifiedMap[link!] = value : null;

  String? get color => _colorMap[link];
  set color(String? value) => link != null ? _colorMap[link!] = value : null;

  List<RssItem>? get items => _itemsMap[link] ?? this.items;
  set items(List<RssItem>? value) => link != null ? _itemsMap[link!] = value : null;
}

extension RosasItemX on RssItem {
  static final Map<int, RssFeed?> _sourceFeedMap = {};

  RssFeed? get sourceFeed => _sourceFeedMap[hashCode];
  set sourceFeed(RssFeed? value) => _sourceFeedMap[hashCode] = value;
}
