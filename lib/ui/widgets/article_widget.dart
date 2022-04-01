import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/models/models_barrel.dart';

class Article extends StatelessWidget {
  final RosasArticle article;

  const Article({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final document = parse(article.parts.first);
    final images = document
        .querySelectorAll('img')
        .map((img) => {
              'url': img.attributes['src'],
              'html': img.outerHtml,
            })
        .toList()
      ..removeWhere(
          (element) => element['url'] == null && element['html'] == null);

    final imageNumber = images.length <= 4 ? images.length : 4;
    String text = article.parts.first;

    for (var image in images) {
      text = text.replaceAll(image['html']!, '');
    }

    text = text.trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: Theme.of(context).textTheme.headline2?.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 8),
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: const Color.fromRGBO(112, 112, 112, 1)),
              ),
              const SizedBox(height: 12),
              article.parts.length > 1
                  ? GestureDetector(
                      onTap: () {},
                      child: Text(
                        'Read more (${article.parts.length - 1} other parts)'
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                                color: Theme.of(context).colorScheme.secondary),
                      ))
                  : Container(),
            ],
          ),
        ),
        images.isNotEmpty
            ? AspectRatio(
                aspectRatio: 16 / 9,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: images.length > 2 ? 2 : 1,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 4),
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  children:
                      images.toList().sublist(0, imageNumber).map((image) {
                    return FittedBox(
                      child: Image.network(image['url']!),
                      fit: BoxFit.cover,
                    );
                  }).toList(),
                ),
              )
            : Container(),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      //  TODO: open source_page
                    },
                    child: Text(
                      article.source.title,
                      style: Theme.of(context).textTheme.caption?.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  Text(
                    ' / ${article.published.toIso8601String()}',
                    style: Theme.of(context).textTheme.caption?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
              Row(
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
