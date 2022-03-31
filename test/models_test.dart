import 'package:flutter_test/flutter_test.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/services_barrel.dart';

void main() {
  test('Search sources with Feedly service', () async {
    final sources = await Feedly.searchSource('the new york times');
    expect(sources.length, greaterThan(0));
    expect(sources.first, isA<RosasSource>());
    expect(sources.first.title, isA<String>());
    expect(sources.first.url, isA<String>());
    expect(sources.first.topics.first.name, isA<String>());
  });

  test('Get articles of a source with Feedly service', () async {
    final source = (await Feedly.searchSource('frandroid')).first;
    final articles = await Feedly.getSourceArticles(source);

    expect(articles.length, greaterThan(0));
    expect(articles.first, isA<RosasArticle>());
    expect(articles.first.source.url, equals(source.url));
    expect(articles.first.published, isA<DateTime>());
    expect(articles.first.title, isA<String>());
    expect(articles.first.parts.length, greaterThan(0));
    expect(articles.first.parts.first, isA<String>());
  });
}
