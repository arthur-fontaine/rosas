import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rosas/models/PaperFeed.dart';
import 'package:rosas/models/PapersResults.dart';
import 'package:rosas/models/PodcastsResults.dart';
import 'package:rosas/pages/SourceView.dart';
import 'package:rosas/widgets/NPCardList.dart';
import 'package:rosas/widgets/SquareCard.dart';
import 'package:rosas/widgets/Subtitle.dart';
import 'dart:math';
import 'package:rosas/pages/AddSource.dart';
import 'package:rosas/pages/Player.dart';
import 'package:rosas/pages/Reader.dart';
import 'package:webfeed/webfeed.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rosas',
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home: MyHomePage(title: 'Rosas'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ScrollPosition scrollPosition;
  List<PaperResult> subscribedNewsFeeds;
  List<PodcastResult> subscribedPodcastFeeds;
  NPCardList newsFeedsNPCards;
  NPCardList podcastFeedsNPCards;
  List<Widget> sourceSquareCards;

  @override
  void initState() {
    super.initState();

    subscribedNewsFeeds = [];
    subscribedPodcastFeeds = [];
  }

  void _fetchNPCardList() {
    setState(() {
      newsFeedsNPCards = NPCardList(
        feeds: subscribedNewsFeeds,
        onCardClick: (item, feed, coverImgUrl) {
          String sourceImgUrl;
          String title;

          if (feed is RssFeed) {
            sourceImgUrl = feed.image.url;
            title = feed.title;
          } else if (feed is PaperFeed) {
            // sourceImgUrl = feed.;
            title = feed.title;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Reader(
                item: item,
                coverImgUrl: coverImgUrl,
                sourceImgUrl: sourceImgUrl,
                source: title,
              ),
            ),
          );
        },
      );

      podcastFeedsNPCards = NPCardList(
        feeds: subscribedPodcastFeeds,
        onCardClick: (item, feed, coverImgUrl) {
          String sourceImgUrl;

          if (feed is PodcastResult) {
            sourceImgUrl = feed.artworkUrl600;
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Player(
                // coverUrl: item.itunes.image,
                coverUrl: coverImgUrl ?? sourceImgUrl,
                playing: item,
              ),
            ),
          );
        },
      );

      sourceSquareCards =
          [...subscribedNewsFeeds, ...subscribedPodcastFeeds].map((feed) {
        String sourceImgUrl;

        if (feed is PaperResult) {
          sourceImgUrl = feed.visualUrl;
        } else if (feed is PodcastResult) {
          sourceImgUrl = feed.artworkUrl600;
        }

        return GestureDetector(
          onTap: () async {
            final Object toRemove = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SourceView(feed: feed)),
            );

            if (toRemove != null) {
              setState(() {
                if (toRemove is PaperResult) {
                  subscribedNewsFeeds.removeWhere(
                      (element) => element.feedId == toRemove.feedId);
                } else if (toRemove is PodcastResult) {
                  subscribedPodcastFeeds.removeWhere(
                      (element) => element.feedUrl == toRemove.feedUrl);
                }
              });
            }
          },
          child: Transform.translate(
            offset: Offset(-12.5, 0),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12.5),
              child: SquareCard(
                background: Image.network(sourceImgUrl),
              ),
            ),
          ),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _scr = PrimaryScrollController.of(context);

    _fetchNPCardList();

    _scr.addListener(() {
      setState(() {
        scrollPosition = _scr.position;
      });
    });

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          // controller: _scr,
          slivers: [
            SliverAppBar(
              pinned: true,
              backgroundColor: Colors.black,
              expandedHeight: 312.5,
              collapsedHeight: 151,
              flexibleSpace: Center(
                child: Image.asset(
                  'assets/images/rosas-header.png',
                  width: _width * 0.6,
                ),
              ),
              bottom: PreferredSize(
                child: Container(
                  child: scrollPosition == null ||
                          scrollPosition.pixels / ((312.5 - 151) * 0.5) <= 1
                      ? Opacity(
                          opacity: scrollPosition != null
                              ? 1 -
                                  scrollPosition.pixels / ((312.5 - 151) * 0.5)
                              : 1,
                          child: Container(
                            child: GestureDetector(
                              onTap: () async {
                                final List<Object> toAdd = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddSource(),
                                  ),
                                );

                                setState(() {
                                  toAdd.forEach((element) {
                                    if (element is PaperResult) {
                                      subscribedNewsFeeds.add(element);
                                    } else if (element is PodcastResult) {
                                      subscribedPodcastFeeds.add(element);
                                    }
                                  });
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.only(bottom: 25),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9999),
                                    color: Color.fromARGB(255, 239, 250, 251),
                                  ),
                                  child: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      Text('Add'),
                                    ],
                                  )),
                            ),
                          ),
                        )
                      : Container(),
                ),
                preferredSize: Size(_width, 0),
              ),
              actions: [
                Transform.rotate(
                  angle: 90 * pi / 180,
                  child: scrollPosition == null ||
                          scrollPosition.pixels / ((312.5 - 151) * 0.5) <= 1
                      ? Opacity(
                          opacity: scrollPosition != null
                              ? 1 -
                                  scrollPosition.pixels / ((312.5 - 151) * 0.5)
                              : 1,
                          child: IconButton(
                            icon: Icon(Icons.tune_rounded),
                            color: Colors.white,
                            onPressed: () => {},
                          ),
                        )
                      : Container(),
                )
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                subscribedNewsFeeds.isNotEmpty
                    ? Subtitle(subtitle: 'News')
                    : Container(),
                subscribedNewsFeeds.isNotEmpty ? newsFeedsNPCards : Container(),
                subscribedPodcastFeeds.isNotEmpty
                    ? Subtitle(subtitle: 'Podcasts')
                    : Container(),
                subscribedPodcastFeeds.isNotEmpty
                    ? podcastFeedsNPCards
                    : Container(),
                subscribedNewsFeeds.isNotEmpty ||
                        subscribedPodcastFeeds.isNotEmpty
                    ? Subtitle(subtitle: 'Sources')
                    : Container(),
                subscribedNewsFeeds.isNotEmpty ||
                        subscribedPodcastFeeds.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.symmetric(horizontal: 12.5),
                        child: SingleChildScrollView(
                            child: Row(
                          children: [
                            Padding(padding: EdgeInsets.only(left: 12.5)),
                            ...sourceSquareCards,
                            Padding(padding: EdgeInsets.only(right: 12.5)),
                          ],
                        )))
                    : Container(),
                subscribedNewsFeeds.isEmpty && subscribedPodcastFeeds.isEmpty
                    ? Container(
                        margin: EdgeInsets.all(25),
                        child: Center(
                          child: Text('No feed to show'),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: EdgeInsets.only(bottom: 25),
                )
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
