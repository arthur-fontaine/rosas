import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:html/parser.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/generated/l10n.dart';
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
                        S
                            .of(context)
                            .readMore(article.parts.length - 1)
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
          padding: EdgeInsets.only(
              bottom: 16, right: 16, left: 16, top: images.isNotEmpty ? 16 : 0),
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
                    ' / ${S.of(context).ago(prettyDuration(
                          DateTime.now().difference(article.published),
                          abbreviated: false,
                          first: true,
                          locale: DurationLocale.fromLanguageCode(
                                  Localizations.localeOf(context)
                                      .languageCode) ??
                              const EnglishDurationLocale(),
                        ))}',
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
