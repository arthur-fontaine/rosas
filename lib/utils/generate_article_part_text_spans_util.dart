import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:rosas/utils/util_barrel.dart';
import 'package:url_launcher/url_launcher.dart';

List<TextSpan> generateArticlePartTextSpan(BuildContext context, String part) {
  // final links = part.parsedLinks;

  // final List<int> cutPositions = [
  //   0,
  //   ...links.map((link) => link.startPosition),
  //   ...links.map((link) => link.endPosition),
  //   text.length - 1
  // ];
  // final List<List<int>> textCuts = [];
  //
  // cutPositions.sublist(0, cutPositions.length - 1).asMap().forEach((i, v) {
  //   textCuts.add([v, cutPositions[i + 1]]);
  // });
  //
  // final splits = textCuts.map((f) => text.substring(f[0], f[1]));
  //
  // final List<TextSpan> textWidgets = [];
  //
  // splits.toList().asMap().forEach((index, split) {
  //   if (index % 2 == 0) {
  //     textWidgets.add(
  //       TextSpan(
  //           text: split,
  //           style: Theme.of(context).textTheme.bodyText1?.copyWith(
  //                 color: Theme.of(context).colorScheme.onBackground,
  //               )),
  //     );
  //   } else {
  //     final link = links[index ~/ 2];
  //     print(link);
  //
  //     textWidgets.add(
  //       TextSpan(
  //         text: split,
  //         style: Theme.of(context).textTheme.bodyText1?.copyWith(
  //               color: Theme.of(context).colorScheme.secondary,
  //               decoration: TextDecoration.underline,
  //             ),
  //         recognizer: TapGestureRecognizer()
  //           ..onTap = () {
  //             launch(link.link);
  //           },
  //       ),
  //     );
  //   }
  // });

  String preprocessedText = preprocessArticlePart(part)['text'] as String;

  final links = parse(preprocessedText).querySelectorAll('a');

  for (var link in links) {
    preprocessedText = preprocessedText.replaceFirst(link.outerHtml, '');
    preprocessedText = preprocessedText.replaceFirst(link.text,
        '[ROSAS-SEP-LINK]${link.attributes['href']}[ROSAS-SEP-TEXT/]${link.text}[ROSAS-SEP-LINK]');
  }

  final List<TextSpan> textWidgets = [];

  preprocessedText
      .split('[ROSAS-SEP-LINK]')
      .toList()
      .asMap()
      .forEach((index, value) {
    if (index % 2 == 0) {
      textWidgets.add(
        TextSpan(
            text: value.trim(),
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: const Color.fromRGBO(112, 112, 112, 1),
                )),
      );
    } else {
      textWidgets.addAll([
        TextSpan(text: ' ', style: Theme.of(context).textTheme.bodyText1),
        TextSpan(
          text: value.split('[ROSAS-SEP-TEXT/]')[1],
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                decoration: TextDecoration.underline,
              ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch(value.split('[ROSAS-SEP-TEXT/]')[0]);
            },
        ),
        TextSpan(text: ' ', style: Theme.of(context).textTheme.bodyText1),
      ]);
    }
  });

  return textWidgets;
}
