import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/ui/search/widgets/search_bar/bloc/search_bar_bloc.dart';
import 'package:rosas/ui/search/widgets/search_widgets_barrel.dart';

class SearchLayout extends StatelessWidget {
  const SearchLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      child: Column(
        children: [
          SearchBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: BlocBuilder<SearchBarBloc, SearchBarState>(
                builder: (context, state) {
                  if (state.status.isNotEmpty) {
                    return const FeedResults();
                  } else {
                    return const SubscribedFeeds();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
