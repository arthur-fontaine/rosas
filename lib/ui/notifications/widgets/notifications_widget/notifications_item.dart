import 'package:flutter/material.dart';

import 'package:html/parser.dart';
import 'package:rosas/utils/utils_barrel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:rosas/models/models_barrel.dart';

import 'package:rosas/themes/themes_barrel.dart';

import '../notifications_widget/notifications_item_header.dart';

class NewsItem extends StatefulWidget {
  final RssItem rssItem;

  const NewsItem({Key? key, required this.rssItem}) : super(key: key);

  @override
  _NewsItemState createState() => _NewsItemState();
}

class _NewsItemState extends State<NewsItem> {
  @override
  Widget build(BuildContext context) {
    final rssItem = widget.rssItem;
    final rssFeed = rssItem.sourceFeed;

    if (rssFeed == null) throw 'sourceFeed of ${rssItem.link} is null.';

    final contentHtml =
        rssItem.content?.value != null ? parse(rssItem.content?.value) : null;
    final firstImage = contentHtml?.querySelector('img[src]');

    final thumbnails = rssItem.media?.thumbnails;
    thumbnails?.sort((thumbnailA, thumbnailB) =>
        (double.tryParse(thumbnailA.height ?? '0') ?? 0)
            .compareTo(double.tryParse(thumbnailB.height ?? '0') ?? 0));
    final selectedThumbnail = thumbnails != null && thumbnails.isNotEmpty
        ? thumbnails.first.url
        : firstImage != null && firstImage.attributes['src'] != null
            ? firstImage.attributes['src']
            : null;

    return InkWell(
      onTap: () async {
        if (rssItem.link != null && !await launch(rssItem.link!)) {
          throw 'Could not launch ${rssItem.link}';
        }
      },
      child: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NewsItemHeader(
              sourceName: rssFeed.title ?? rssFeed.dc?.creator ?? 'Null',
              sourceIcon: rssFeed.image?.url != null ? Image.network(rssFeed.image!.url!) : null,
              placeholderIconColor: rssFeed.color != null ? colorFromHex(rssFeed.color!) : Colors.white,
              publishedAt: rssItem.pubDate ?? DateTime(0),
            ),
            Container(
              padding: const EdgeInsets.only(left: 60),
              child: Column(
                children: [
                  Text(rssItem.title ?? '', style: CustomTextStyles.h3),
                  selectedThumbnail != null
                      ? Container(
                          padding: const EdgeInsets.only(top: 18),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(selectedThumbnail),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
