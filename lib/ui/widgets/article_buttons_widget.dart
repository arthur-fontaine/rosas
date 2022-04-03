import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/models/models_barrel.dart';

class ArticleButtons extends StatelessWidget {
  final RosasArticle article;

  const ArticleButtons({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          onPressed: () {
            context
                .read<ReadLaterBloc>()
                .add(ToggleReadLaterArticle(article));
          },
          icon: BlocBuilder<ReadLaterBloc, ReadLaterState>(
            builder: (context, state) {
              if (state.articles.contains(article)) {
                return const Icon(Icons.bookmark_rounded);
              } else {
                return const Icon(Icons.bookmark_outline_rounded);
              }
            },
          ),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
        const SizedBox(width: 16),
        IconButton(
          onPressed: () {
            //  TODO: share
          },
          icon: const Icon(Icons.share_outlined),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
        ),
      ],
    );
  }
}
