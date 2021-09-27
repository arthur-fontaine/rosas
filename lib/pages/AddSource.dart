import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rosas/models/PapersResults.dart';
import 'package:rosas/models/PodcastsResults.dart';
import 'package:rosas/utils/searchFeeds.dart';

class AddSource extends StatefulWidget {
  AddSource({Key key}) : super(key: key);

  @override
  _AddSourceState createState() => _AddSourceState();
}

class _AddSourceState extends State<AddSource> {
  List<Object> toAdd;
  List<Object> results;

  Timer _debounce;

  @override
  void initState() {
    super.initState();
    toAdd = [];
    results = [];
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 25),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 50, right: 25, left: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add a source...',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        Navigator.pop(context, toAdd);
                      },
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25),
                child: TextField(
                  autofocus: true,
                  decoration: new InputDecoration.collapsed(
                    hintText: "Search for a source...",
                    border: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(1),
                    ),
                  ),
                  onChanged: (term) async {
                    if (_debounce?.isActive ?? false) _debounce.cancel();
                    _debounce =
                        Timer(const Duration(milliseconds: 500), () async {
                      final search = SearchFeeds();

                      final papers = await search.papers(term);
                      final podcasts = await search.podcasts(term);

                      setState(() {
                        results = [...papers.results, ...podcasts.results];
                      });
                    });
                  },
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      ...results.map(
                        (result) {
                          String iconUrl;
                          String title;
                          String type;

                          if (result is PodcastResult) {
                            iconUrl = result.artworkUrl600;
                            title = result.trackName;
                            type = "podcast";
                          } else if (result is PaperResult) {
                            iconUrl = result.visualUrl;
                            title = result.title;
                            type = "paper";
                          }

                          return Container(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 25),
                            child: Row(
                              children: [
                                Container(
                                  width: 64,
                                  height: 64,
                                  margin: EdgeInsets.only(right: 22),
                                  child: iconUrl != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          child: Image.network(
                                            iconUrl.replaceFirst(
                                                'http://', 'https://'),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              title,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        type,
                                        style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        toAdd.add(result);
                                        Navigator.pop(context, toAdd);
                                      });
                                    })
                              ],
                            ),
                          );
                        },
                      ).toList(),
                      Padding(padding: EdgeInsets.only(bottom: 25)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
