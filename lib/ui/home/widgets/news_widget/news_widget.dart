import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intersperse/intersperse.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/themes/custom_text_styles/custom_text_styles.dart';
import 'package:rosas/ui/home/widgets/news_widget/news_barrel.dart';

class News extends StatelessWidget {
  const News({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state.news.isNotEmpty) {
          state.news.sort((a, b) => a.pubDate != null && b.pubDate != null
              ? b.pubDate!.difference(a.pubDate!).inMilliseconds
              : 0);

          return Column(
              children: intersperse(
            const Divider(),
            state.news.map(
              (rssItem) => rssItem.sourceFeed != null
                  ? NewsItem(rssItem: rssItem)
                  : Container(),
            ),
          ).toList());
        } else if (state.status.isSuccess && state.news.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(36),
            child: const Text(
              'Subscribe to feeds to start reading your news!',
              style: CustomTextStyles.h3,
              textAlign: TextAlign.center,
            ),
          );
        } else if (state.status.isError) {
          return const Text('An unexpected error occurred!');
        } else {
          return Container(
            padding: const EdgeInsets.all(36),
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary),
          );
        }
      },
    );
  }
}
