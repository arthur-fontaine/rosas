import 'package:flutter/material.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/ui/widgets/widgets_barrel.dart';
import 'package:rosas/utils/util_barrel.dart';

class ArticlePart extends StatelessWidget {
  final RosasArticle article;
  final int index;

  const ArticlePart({Key? key, required this.article, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final part = article.parts[index];

    final preprocessedPart = preprocessArticlePart(part);
    final images = preprocessedPart['images'] as List<Map<String, String?>>;

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              index > 0
                  ? Container(
                      height: 16,
                      width: 2,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(204, 204, 204, 1),
                      ),
                    )
                  : const SizedBox(height: 16),
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(204, 204, 204, 1),
                  shape: BoxShape.circle,
                ),
              ),
              index < article.parts.length - 1
                  ? Expanded(
                      // fit: FlexFit.loose,
                      child: Container(
                        width: 2,
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(204, 204, 204, 1),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: RichText(
                    text: TextSpan(
                      children: generateArticlePartTextSpan(context, part),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                images.isNotEmpty
                    ? ArticleImageGrid(images: images)
                    : Container(),
                images.isNotEmpty ? const SizedBox(height: 16) : Container(),
                const SizedBox(height: 16)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
