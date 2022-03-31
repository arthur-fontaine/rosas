import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intersperse/intersperse.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/ui/search/widgets/subscribed_feeds/subscribed_feeds_barrel.dart';

class SubscribedFeeds extends StatelessWidget {
  const SubscribedFeeds({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SubscribedFeedsBloc>().add(GetSubscribedFeeds());

    return BlocBuilder<SubscribedFeedsBloc, SubscribedFeedsState>(
      builder: (context, state) => SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: intersperse(
            const Divider(),
            state.subscribedFeeds
                .map((feed) => SubscribedFeedItem(feed: feed)),
          ).toList(),
        ),
      ),
    );
  }
}
