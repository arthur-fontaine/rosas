import 'package:flutter/material.dart';
import 'package:rosas/models/PaperFeed.dart';
import 'package:rosas/models/PapersResults.dart';
import 'package:rosas/models/PodcastsResults.dart';
import 'package:rosas/pages/Player.dart';
import 'package:rosas/pages/Reader.dart';
import 'package:rosas/widgets/NPCardList.dart';
import 'package:rosas/widgets/Subtitle.dart';

class SourceView extends StatelessWidget {
  const SourceView({Key key, this.feed}) : super(key: key);

  final Object feed;

  @override
  Widget build(BuildContext context) {
    String visualUrl;
    String title;

    Object feedB = feed;

    if (feedB is PaperResult) {
      visualUrl = feedB.visualUrl;
      title = feedB.title;
    } else if (feedB is PodcastResult) {
      visualUrl = feedB.artworkUrl600;
      title = feedB.trackName;
    }

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.network(visualUrl, height: 25),
                        Container(
                          margin: EdgeInsets.only(left: 12.5),
                          child: Text(
                            title,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 12.8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        })
                  ],
                ),
              ),
              NPCardList(
                feeds: [feed],
                onCardClick: (item, feed, coverImgUrl) {
                  String sourceImgUrl;
                  String title;

                  if (feed is PaperResult) {
                    visualUrl = feed.visualUrl;
                    title = feed.title;

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
                  } else if (feed is PodcastResult) {
                    visualUrl = feed.artworkUrl600;
                    title = feed.trackName;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Player(
                          // coverUrl: item.itunes.image,
                          coverUrl: coverImgUrl ?? visualUrl,
                          playing: item,
                        ),
                      ),
                    );
                  }
                },
                cardWidth: 265.9,
                cardHeight: 458.49,
                cardPadding: 50,
                firstPadding: 25,
                cardTextPadding: 12,
                cardTextStyle: TextStyle(
                  fontSize: 27.73,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context, feed);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete_outlined, size: 40),
                    Container(
                      constraints: new BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.5),
                      child: Subtitle(
                        subtitle: 'Remove the source',
                        textAlign: TextAlign.center,
                        textStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
