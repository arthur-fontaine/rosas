import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intersperse/intersperse.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/ui/search/widgets/feed_results/feed_results_barrel.dart';
import 'package:rosas/ui/search/widgets/search_bar/search_bar_barrel.dart';

class FeedResults extends StatefulWidget {
  const FeedResults({Key? key}) : super(key: key);

  @override
  _FeedResultsState createState() => _FeedResultsState();
}

class _FeedResultsState extends State<FeedResults> {
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FeedResultsBloc>(
      create: (context) =>
          FeedResultsBloc(feedsRepository: context.read<FeedsRepository>()),
      child: BlocListener<SearchBarBloc, SearchBarState>(
        listener: (context, state) {
          if (_debounce?.isActive ?? false) {
            _debounce!.cancel();
          }

          if (state.status.isNotEmpty) {
            _debounce = Timer(const Duration(milliseconds: 500), () {
              context
                  .read<FeedResultsBloc>()
                  .add(GetFeedResults(searchTerm: state.searchTerm));
            });
          }
        },
        child: BlocBuilder<FeedResultsBloc, FeedResultsState>(
          builder: (context, state) => SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: intersperse(
                const Divider(),
                state.feedResults.map(
                  (feed) => FeedResultItem(feed: feed),
                ),
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
