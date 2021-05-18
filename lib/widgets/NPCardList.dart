import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rosas/models/PaperFeed.dart';
import 'package:rosas/models/PapersResults.dart';
import 'package:rosas/models/PodcastsResults.dart';
import 'package:rosas/widgets/NPCard.dart';
import 'package:rosas/utils/parseFeed.dart';
import 'package:webfeed/webfeed.dart';

class NPCardList extends StatelessWidget {
  const NPCardList(
      {Key key,
      @required this.feeds,
      this.onCardClick,
      this.cardWidth,
      this.cardHeight,
      this.firstPadding,
      this.cardPadding,
      this.cardTextPadding,
      this.cardTextStyle})
      : super(key: key);

  final List<Object> feeds;
  final void Function(Object, Object, String) onCardClick;
  final double cardWidth;
  final double cardHeight;
  final double firstPadding;
  final double cardPadding;
  final double cardTextPadding;
  final TextStyle cardTextStyle;

  Future<List<Object>> _parseFeeds(List<Object> feeds) async {
    final parse = ParseFeed();

    return await Future.wait(feeds.map((feed) async {
      if (feed is PodcastResult) {
        return await parse.podcast(feed.feedUrl);
      } else if (feed is PaperResult) {
        return await parse.paper(feed.feedId);
      } else {
        return [];
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _parseFeeds(feeds),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Object> feeds = snapshot.data;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Transform.translate(
              offset: Offset(
                  firstPadding != null && cardPadding != null
                      ? firstPadding - cardPadding
                      : 0,
                  0),
              child: Container(
                child: Row(
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: ((cardPadding ?? 25) / 2))),
                    ...feeds
                        .map((feed) {
                          List<Object> items;

                          if (feed is RssFeed) {
                            items = feed.items;
                          } else if (feed is PaperFeed) {
                            items = feed.items;
                          }

                          return items.map(
                            (item) {
                              String contentEncoded;
                              String coverImgUrl;
                              String title;

                              RegExp coverImgUrlPattern = new RegExp(
                                r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&\/\/=]*)\.(?:jpg|jpeg|png|gif|tiff)",
                                multiLine: true,
                              );

                              if (item is RssItem) {
                                print(item);
                                coverImgUrl = item.itunes.image.href;
                                title = item.title;
                              } else if (item is PaperItem) {
                                contentEncoded = item.content.content;
                                coverImgUrl = coverImgUrlPattern
                                    .firstMatch(contentEncoded)
                                    ?.group(0)
                                    ?.toString();
                                title = item.title;
                              }

                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: (cardPadding ?? 25) / 2),
                                child: GestureDetector(
                                  onTap: () =>
                                      onCardClick(item, feed, coverImgUrl),
                                  child: NPCard(
                                    title: title,
                                    background: Image.network(
                                      coverImgUrl,
                                      fit: BoxFit.cover,
                                    ),
                                    contentEncoded: contentEncoded,
                                    width: cardWidth,
                                    height: cardHeight,
                                    textStyle: cardTextStyle,
                                    textPadding: cardTextPadding,
                                  ),
                                ),
                              );
                            },
                          ).toList();
                        })
                        .toList()
                        .expand((i) => i)
                        .toList(),
                    Padding(padding: EdgeInsets.only(right: 12.5)),
                  ],
                ),
              ),
            ),
          );
        } else {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Transform.translate(
              offset: Offset(
                  firstPadding != null && cardPadding != null
                      ? firstPadding - cardPadding
                      : 0,
                  0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                        padding:
                            EdgeInsets.only(left: ((cardPadding ?? 25) / 2))),
                    ...feeds.map((feed) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: (cardPadding ?? 25) / 2),
                        child: NPCard(
                          title: 'Loading...',
                          background: Container(
                            color: Colors.grey[800],
                          ),
                          width: cardWidth,
                          height: cardHeight,
                          textStyle: cardTextStyle,
                          textPadding: cardTextPadding,
                        ),
                      );
                    }).toList(),
                    Padding(padding: EdgeInsets.only(right: 12.5)),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
