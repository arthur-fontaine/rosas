import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/ui/pages/article/widgets/article_part_widget.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';

class ArticlePage extends StatelessWidget {
  static const String route = 'article';

  final RosasArticle article;

  const ArticlePage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Theme.of(context).colorScheme.background,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: SafeArea(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                    color: Color.fromRGBO(230, 230, 230, 1),
                    width: 1,
                    style: BorderStyle.solid,
                  ))),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.arrow_back_rounded)),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              article.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground),
                            ),
                            const SizedBox(height: 8),
                            ArticleCaption(article: article),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children:
                          List<int>.generate(article.parts.length, (i) => i)
                              .map((index) =>
                                  ArticlePart(article: article, index: index))
                              .toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
