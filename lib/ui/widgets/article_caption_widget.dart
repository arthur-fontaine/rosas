import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:rosas/generated/l10n.dart';
import 'package:rosas/models/models_barrel.dart';

class ArticleCaption extends StatelessWidget {
  final RosasArticle article;

  const ArticleCaption({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
