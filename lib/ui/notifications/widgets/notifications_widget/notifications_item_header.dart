import 'package:flutter/material.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:rosas/themes/themes_barrel.dart';

class NewsItemHeader extends StatefulWidget {
  final String sourceName;
  final Image? sourceIcon;
  final Color placeholderIconColor;
  final DateTime publishedAt;

  const NewsItemHeader({
    Key? key,
    required this.sourceName,
    required this.sourceIcon,
    required this.publishedAt,
    this.placeholderIconColor = Colors.white,
  }) : super(key: key);

  @override
  _NewsItemHeaderState createState() => _NewsItemHeaderState();
}

class _NewsItemHeaderState extends State<NewsItemHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: widget.sourceIcon?.image != null
                  ? DecorationImage(
                      image: widget.sourceIcon!.image,
                      fit: BoxFit.cover,
                    )
                  : null,
              color: widget.placeholderIconColor
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  child: Text(widget.sourceName, style: CustomTextStyles.h2),
                  padding: const EdgeInsets.only(bottom: 3),
                ),
                Text(timeago.format(widget.publishedAt),
                    style: CustomTextStyles.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
