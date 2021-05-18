import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:rosas/models/PaperFeed.dart';
import 'package:rosas/models/ParsedFeed.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class Reader extends StatefulWidget {
  Reader({Key key, this.item, this.coverImgUrl, this.sourceImgUrl, this.source})
      : super(key: key);

  final PaperItem item;
  final String sourceImgUrl;
  final String source;
  final String coverImgUrl;

  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  ScrollPosition scrollPosition;

  @override
  Widget build(BuildContext context) {
    final _scr2 = PrimaryScrollController.of(context);

    _scr2.addListener(() {
      setState(() {
        scrollPosition = _scr2.position;
      });
    });

    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Stack(
            children: [
              // ? Header of the reader
              Container(
                height: 363,
                child: Stack(
                  children: [
                    // ? Cover of the article
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(widget.coverImgUrl),
                        ),
                      ),
                    ),
                    // ? Gradient
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent]),
                      ),
                    ),
                    // ? Bar of the reader
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ? Close button
                        IconButton(
                            icon: new Icon(Icons.close_rounded),
                            color: Colors.white,
                            onPressed: () {}),
                        // ? Share button + Save button
                        Row(
                          children: [
                            // ? Share button
                            IconButton(
                                icon: new Icon(Icons.share_outlined),
                                color: Colors.white,
                                onPressed: () {}),
                            // ? Save button
                            IconButton(
                                icon: new Icon(Icons.bookmark_outline_rounded),
                                color: Colors.white,
                                onPressed: () {}),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: EdgeInsets.only(top: (363 - 25).toDouble()),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 239, 250, 251),
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.only(
                          left: 25, top: 25, right: 25, bottom: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ? Author + Title
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // ? Author
                              Container(
                                  margin: EdgeInsets.only(bottom: 12.5),
                                  child: Row(
                                    children: [
                                      widget.sourceImgUrl != null
                                          ? Image.network(widget.sourceImgUrl)
                                          : Container(),
                                      Text(
                                        widget.source,
                                        style: TextStyle(
                                          fontSize: 12.8,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    ],
                                  )),
                              // ? Title
                              Text(
                                widget.item.title,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                          Html(
                            data: widget.item.content.content.replaceAllMapped(
                              RegExp(r'(<img[^>]+)(height=)',
                                  caseSensitive: false),
                              (match) => match.group(1) + '_' + match.group(1),
                            ),
                            onLinkTap: (String url) {
                              launch(url);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              scrollPosition == null || scrollPosition.pixels < 307
                  ? Opacity(
                      opacity: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // ? Close button
                          IconButton(
                              icon: new Icon(Icons.close_rounded),
                              color: Colors.white,
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                          // ? Share button + Save button
                          Row(
                            children: [
                              // ? Share button
                              IconButton(
                                  icon: new Icon(Icons.share_outlined),
                                  color: Colors.white,
                                  onPressed: () {
                                    Share.share(widget.item.canonical[0].href);
                                  }),
                              // ? Save button
                              IconButton(
                                  icon:
                                      new Icon(Icons.bookmark_outline_rounded),
                                  color: Colors.white,
                                  onPressed: () {}),
                            ],
                          )
                        ],
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
