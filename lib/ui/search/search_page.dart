import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/repositories/feeds_repository.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/ui/notifications/widgets/notifications_widget/bloc/notifications_bloc.dart';
import 'package:rosas/ui/search/search_layout.dart';
import 'package:rosas/ui/search/widgets/feed_results/bloc/feed_results_bloc.dart';
import 'package:rosas/ui/search/widgets/search_bar/bloc/search_bar_bloc.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider<FeedResultsBloc>(
            create: (context) => FeedResultsBloc(
                feedsRepository: context.read<FeedsRepository>()),
          ),
          BlocProvider<SearchBarBloc>(
            create: (context) => SearchBarBloc(
                searchRepository: context.read<SearchRepository>()),
          ),
          BlocProvider<NotificationsBloc>(
            create: (context) => NotificationsBloc(
                notificationsRepository:
                    context.read<NotificationsRepository>(),
                feedsRepository: context.read<FeedsRepository>()),
          ),
        ],
        child: const SearchLayout(),
      ),
    );
  }
}
