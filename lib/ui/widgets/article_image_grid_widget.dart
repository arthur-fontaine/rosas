import 'package:flutter/material.dart';

class ArticleImageGrid extends StatelessWidget {
  final List<Map<String, String?>> images;
  final double? aspectRatio;

  const ArticleImageGrid({Key? key, required this.images, this.aspectRatio})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return images.isNotEmpty
        ? AspectRatio(
            aspectRatio: aspectRatio ?? 16 / 9,
            child: Row(
              children: images.length == 1
                  ? [ArticleImage(imageUrl: images[0]['url']!)]
                  : [
                      Column(
                        children: images.length <= 3
                            ? [ArticleImage(imageUrl: images[0]['url']!)]
                            : [
                                ArticleImage(imageUrl: images[0]['url']!),
                                ArticleImage(imageUrl: images[1]['url']!),
                              ],
                      ),
                      Column(
                        children: images.length == 2
                            ? [ArticleImage(imageUrl: images[1]['url']!)]
                            : images.length == 3
                                ? [
                                    ArticleImage(imageUrl: images[1]['url']!),
                                    ArticleImage(imageUrl: images[2]['url']!),
                                  ]
                                : [
                                    ArticleImage(imageUrl: images[2]['url']!),
                                    ArticleImage(imageUrl: images[3]['url']!),
                                  ],
                      ),
                    ],
            ),
          )
        : Container();
  }
}

class ArticleImage extends StatelessWidget {
  final String imageUrl;

  const ArticleImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Image.network(imageUrl, fit: BoxFit.cover),
        decoration: const BoxDecoration(),
        clipBehavior: Clip.hardEdge,
      ),
    );
  }
}
