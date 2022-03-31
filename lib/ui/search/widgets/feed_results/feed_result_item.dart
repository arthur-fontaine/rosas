import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:rosas/models/models_barrel.dart';

import 'package:rosas/themes/themes_barrel.dart';
import 'package:rosas/ui/notifications/widgets/notifications_widget/notifications_barrel.dart';
import 'package:rosas/ui/search/widgets/feed_results/feed_results_barrel.dart';

class FeedResultItem extends StatefulWidget {
  final RssFeed feed;

  const FeedResultItem({Key? key, required this.feed}) : super(key: key);

  @override
  _FeedResultItemState createState() => _FeedResultItemState();
}

class _FeedResultItemState extends State<FeedResultItem> {
  late final RssFeed _feed;
  late bool _subscribed;
  late bool _toBeNotified;

  @override
  void initState() {
    _feed = widget.feed;
    _subscribed = _feed.subscribed ?? false;
    _toBeNotified = _feed.toBeNotified ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(36),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 12),
                  height: 64,
                  width: 64,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _feed.image?.url == null ? Colors.white : null,
                    image: _feed.image?.url != null
                        ? DecorationImage(
                            image: Image.network(_feed.image!.url!).image,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _feed.title ?? '',
                        style: CustomTextStyles.h2,
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                        softWrap: false,
                      ),
                      _feed.categories != null
                          ? Text(
                              _feed.categories!
                                  .map((category) => category.value)
                                  .join(', '),
                              style: CustomTextStyles.body,
                              maxLines: 1,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  final notificationsBloc = context.read<NotificationsBloc>();
                  final feedResultsBloc = context.read<FeedResultsBloc>();

                  if (_toBeNotified) {
                    notificationsBloc.add(UnsubscribeToNotifications(feed: _feed));
                    setState(() {
                      _toBeNotified = false;
                    });
                  } else {
                    notificationsBloc.add(SubscribeToNotifications(feed: _feed));
                    feedResultsBloc.add(SubscribeFeed(feed: _feed));
                    setState(() {
                      _toBeNotified = true;
                      _subscribed = true;
                    });
                  }
                },
                icon: _toBeNotified == true
                    ? const HeroIcon(HeroIcons.heart, solid: true,)
                    : const HeroIcon(HeroIcons.heart),
              ),
              IconButton(
                onPressed: () {
                  final feedResultsBloc = context.read<FeedResultsBloc>();

                  if (_subscribed) {
                    feedResultsBloc.add(UnsubscribeFeed(feed: _feed));
                    setState(() {
                      _subscribed = false;
                    });
                  } else {
                    feedResultsBloc.add(SubscribeFeed(feed: _feed));
                    setState(() {
                      _subscribed = true;
                    });
                  }
                },
                icon: _subscribed == true
                    ? const HeroIcon(HeroIcons.check)
                    : const HeroIcon(HeroIcons.plus),
              ),
            ],
          )
        ],
      ),
    );
  }
}
