// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:heroicons/heroicons.dart';
// import 'package:rosas/models/models_barrel.dart';
//
// import 'package:rosas/themes/themes_barrel.dart';
// import 'package:rosas/ui/search/widgets/subscribed_feeds/subscribed_feeds_barrel.dart';
//
// class SubscribedFeedItem extends StatelessWidget {
//   final RssFeed feed;
//
//   const SubscribedFeedItem({Key? key, required this.feed}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(18),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Expanded(
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(right: 18),
//                   height: 64,
//                   width: 64,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: feed.image?.url == null ? Colors.white : null,
//                     image: feed.image?.url != null
//                         ? DecorationImage(
//                       image: Image.network(feed.image!.url!).image,
//                       fit: BoxFit.cover,
//                     )
//                         : null,
//                   ),
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         feed.title ?? '',
//                         style: CustomTextStyles.h2,
//                         maxLines: 1,
//                         overflow: TextOverflow.fade,
//                         softWrap: false,
//                       ),
//                       feed.categories != null
//                           ? Text(
//                           feed.categories!
//                               .map((category) => category.value)
//                               .join(', '),
//                           style: CustomTextStyles.body)
//                           : Container()
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           IconButton(
//             onPressed: () {
//               context.read<SubscribedFeedsBloc>().add(UnsubscribeFeed(feed: feed));
//             },
//             icon: const HeroIcon(HeroIcons.check),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:rosas/models/models_barrel.dart';

import 'package:rosas/themes/themes_barrel.dart';
import 'package:rosas/ui/notifications/widgets/notifications_widget/notifications_barrel.dart';
import 'package:rosas/ui/search/widgets/subscribed_feeds/subscribed_feeds_barrel.dart';

class SubscribedFeedItem extends StatefulWidget {
  final RssFeed feed;

  const SubscribedFeedItem({Key? key, required this.feed}) : super(key: key);

  @override
  _SubscribedFeedItemState createState() => _SubscribedFeedItemState();
}

class _SubscribedFeedItemState extends State<SubscribedFeedItem> {
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
      padding: const EdgeInsets.all(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 18),
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
                              style: CustomTextStyles.body)
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

                  if (_toBeNotified) {
                    notificationsBloc
                        .add(UnsubscribeToNotifications(feed: _feed));
                    setState(() {
                      _toBeNotified = false;
                    });
                  } else {
                    notificationsBloc
                        .add(SubscribeToNotifications(feed: _feed));
                    setState(() {
                      _toBeNotified = true;
                      _subscribed = true;
                    });
                  }
                },
                icon: _toBeNotified == true
                    ? const HeroIcon(
                        HeroIcons.heart,
                        solid: true,
                      )
                    : const HeroIcon(HeroIcons.heart),
              ),
              IconButton(
                onPressed: () {
                  if (_subscribed) {
                    context
                        .read<SubscribedFeedsBloc>()
                        .add(UnsubscribeFeed(feed: _feed));
                    context
                        .read<NotificationsBloc>()
                        .add(UnsubscribeToNotifications(feed: _feed));
                    setState(() {
                      _subscribed = false;
                      _toBeNotified = false;
                    });
                  }
                },
                icon: _subscribed == true
                    ? const HeroIcon(HeroIcons.check)
                    : const HeroIcon(HeroIcons.plus),
              ),
            ],
          )
          // IconButton(
          //   onPressed: () {
          //     context.read<SubscribedFeedsBloc>().add(UnsubscribeFeed(feed: feed));
          //   },
          //   icon: const HeroIcon(HeroIcons.check),
          // ),
        ],
      ),
    );
  }
}
