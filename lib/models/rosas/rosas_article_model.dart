part of 'rosas_model.dart';

class RosasArticle extends Equatable {
  final String title;
  final String url;
  final DateTime published;
  final RosasSource source;
  late final List<String> parts;

  RosasArticle(this.title, this.url, this.published, this.source, content) {
    parts = [];

    final document = parse(content);
    List<Element> parsedElements;

    if (document.body != null) {
      parsedElements = document.body!.querySelectorAll('*');
    } else {
      parsedElements = document.querySelectorAll('*');
    }

    List<String> currentPart = [];
    for (var element in parsedElements) {
      if (!(element.outerHtml.startsWith('<img ') &&
              element.attributes.containsKey('src')) &&
          !(element.outerHtml.startsWith('<a ') &&
              element.attributes.containsKey('href'))) {
        element.text.split(' ').forEach((word) {
          if (currentPart.join(' ').length + word.length >= 280) {
            parts.add(
                currentPart.join(' ').replaceAll(RegExp(r'\n{2,}'), '\n\n'));
            currentPart = [];
          }

          currentPart.add(word);
        });
      } else {
        if (!(element.outerHtml.startsWith('<a ') &&
            element.attributes.containsKey('href') &&
            element.text.isEmpty)) {
          currentPart.add(element.outerHtml);
        }
      }

      currentPart.add('\n');
    }

    if (currentPart.isNotEmpty) {
      parts.add(currentPart.join(' ').replaceAll(RegExp(r'\n{2,}'), '\n\n'));
      currentPart = [];
    }
  }

  @override
  List<Object?> get props => [title, url];
}
