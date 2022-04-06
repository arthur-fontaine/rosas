// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:html/parser.dart';
// import 'package:rosas/models/models_barrel.dart';
// import 'package:rosas/ui/widgets/widgets_barrel.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// Map<String, dynamic> preprocessArticlePart(String part) {
//   final document = parse(part);
//   final images = document
//       .querySelectorAll('img')
//       .map((img) => {
//             'url': img.attributes['src'],
//             'html': img.outerHtml,
//           })
//       .toList()
//     ..removeWhere(
//         (element) => element['url'] == null && element['html'] == null);
//
//   String text = part;
//
//   for (var image in images) {
//     text = text.replaceAll(image['html']!, '');
//   }
//
//   text = text.replaceAll(RegExp(r'\n '), '\n');
//   text = text.trim();
//
//   return {
//     'text': text,
//     'images': images,
//   };
// }
//
// List<TextSpan> generateArticlePartTextSpan(
//     BuildContext context, RosasArticlePart part) {
//   final text = part.parsedContent;
//   // final links = part.parsedLinks;
//
//   // final List<int> cutPositions = [
//   //   0,
//   //   ...links.map((link) => link.startPosition),
//   //   ...links.map((link) => link.endPosition),
//   //   text.length - 1
//   // ];
//   // final List<List<int>> textCuts = [];
//   //
//   // cutPositions.sublist(0, cutPositions.length - 1).asMap().forEach((i, v) {
//   //   textCuts.add([v, cutPositions[i + 1]]);
//   // });
//   //
//   // final splits = textCuts.map((f) => text.substring(f[0], f[1]));
//   //
//   // final List<TextSpan> textWidgets = [];
//   //
//   // splits.toList().asMap().forEach((index, split) {
//   //   if (index % 2 == 0) {
//   //     textWidgets.add(
//   //       TextSpan(
//   //           text: split,
//   //           style: Theme.of(context).textTheme.bodyText1?.copyWith(
//   //                 color: Theme.of(context).colorScheme.onBackground,
//   //               )),
//   //     );
//   //   } else {
//   //     final link = links[index ~/ 2];
//   //     print(link);
//   //
//   //     textWidgets.add(
//   //       TextSpan(
//   //         text: split,
//   //         style: Theme.of(context).textTheme.bodyText1?.copyWith(
//   //               color: Theme.of(context).colorScheme.secondary,
//   //               decoration: TextDecoration.underline,
//   //             ),
//   //         recognizer: TapGestureRecognizer()
//   //           ..onTap = () {
//   //             launch(link.link);
//   //           },
//   //       ),
//   //     );
//   //   }
//   // });
//
//   String preprocessedText = preprocessArticlePart(text)['text'] as String;
//
//   final links = parse(preprocessedText).querySelectorAll('a');
//
//   for (var link in links) {
//     preprocessedText = preprocessedText.replaceFirst(link.outerHtml, '');
//     preprocessedText = preprocessedText.replaceFirst(link.text,
//         '[ROSAS-SEP-LINK]${link.attributes['href']}[ROSAS-SEP-TEXT/]${link.text}[ROSAS-SEP-LINK]');
//   }
//
//   final List<TextSpan> textWidgets = [];
//
//   preprocessedText
//       .split('[ROSAS-SEP-LINK]')
//       .toList()
//       .asMap()
//       .forEach((index, value) {
//     if (index % 2 == 0) {
//       textWidgets.add(
//         TextSpan(
//             text: value,
//             style: Theme.of(context).textTheme.bodyText1?.copyWith(
//                   color: Theme.of(context).colorScheme.onBackground,
//                 )),
//       );
//     } else {
//       textWidgets.add(
//         TextSpan(
//           text: value.split('[ROSAS-SEP-TEXT/]')[1],
//           style: Theme.of(context).textTheme.bodyText1?.copyWith(
//                 color: Theme.of(context).colorScheme.secondary,
//                 decoration: TextDecoration.underline,
//               ),
//           recognizer: TapGestureRecognizer()
//             ..onTap = () {
//               launch(value.split('[ROSAS-SEP-TEXT/]')[0]);
//             },
//         ),
//       );
//     }
//   });
//
//   return textWidgets;
// }
//
// class ArticlePartContent extends StatelessWidget {
//   final RosasArticlePart part;
//   final RosasArticle article;
//
//   const ArticlePartContent(
//       {Key? key, required this.part, required this.article})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final images = part.images;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 16),
//         Padding(
//           padding: const EdgeInsets.only(right: 16),
//           child: RichText(
//             text: TextSpan(
//               children: generateArticlePartTextSpan(context, part),
//             ),
//           ),
//         ),
//         const SizedBox(height: 16),
//         images.isNotEmpty
//             ? Container(
//                 constraints: const BoxConstraints.expand(),
//                 child: ArticleImageGrid(images: images, aspectRatio: 4 / 3))
//             : Container(),
//         images.isNotEmpty ? const SizedBox(height: 16) : Container(),
//         Container(
//           padding: const EdgeInsets.only(right: 16),
//           child: ArticleButtons(article: article),
//           alignment: Alignment.centerRight,
//         )
//       ],
//     );
//   }
// }
