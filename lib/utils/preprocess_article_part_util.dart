import 'package:html/parser.dart';

Map<String, dynamic> preprocessArticlePart(String part) {
  final document = parse(part);
  final images = document
      .querySelectorAll('img')
      .map((img) => {
    'url': img.attributes['src'],
    'html': img.outerHtml,
  })
      .toList()
    ..removeWhere(
            (element) => element['url'] == null && element['html'] == null);

  String text = part;

  for (var image in images) {
    text = text.replaceAll(image['html']!, '');
  }

  text = text.replaceAll(RegExp(r'\n '), '\n');
  text = text.trim();

  return {
    'text': text,
    'images': images,
  };
}
