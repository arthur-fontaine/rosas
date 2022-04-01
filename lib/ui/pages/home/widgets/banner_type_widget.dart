import 'package:flutter/material.dart';
import 'package:rosas/generated/l10n.dart';

enum BannerType { notifications, readLater, feed }

class BannerTypeWidget extends StatelessWidget {
  final BannerType type;
  final Color color;

  const BannerTypeWidget(
      {Key? key,
      this.type = BannerType.feed,
      this.color = const Color.fromRGBO(112, 112, 112, 1)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final String text;

    if (type == BannerType.feed) {
      text = S.of(context).yourFeed;
    } else if (type == BannerType.readLater) {
      text = S.of(context).readLater;
    } else if (type == BannerType.notifications) {
      text = S.of(context).unreadNotifications;
    } else {
      text = '';
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12).copyWith(top: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Divider(color: color)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              text.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(color: color),
            ),
          ),
          Expanded(child: Divider(color: color)),
        ],
      ),
    );
  }
}
