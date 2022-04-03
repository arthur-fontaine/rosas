import 'package:flutter/material.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/ui/pages/pages_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';
import 'package:rosas/utils/util_barrel.dart';

class ArticlePageArguments {
  final RosasArticle article;

  ArticlePageArguments(this.article);
}

class ArticlePreview extends StatelessWidget {
  final RosasArticle article;

  const ArticlePreview({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final preprocessedPart = preprocessArticlePart(article.parts.first);
    final text = preprocessedPart['text'] as String;
    final images = preprocessedPart['images'] as List<Map<String, String?>>;

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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          ArticlePage.route,
                          arguments: ArticlePageArguments(article),
                        );
                      },
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
        ArticleImageGrid(images: images),
        Padding(
          padding: EdgeInsets.only(
              bottom: 16, right: 16, left: 16, top: images.isNotEmpty ? 16 : 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArticleCaption(article: article),
              ArticleButtons(article: article),
            ],
          ),
        ),
      ],
    );
  }
}
