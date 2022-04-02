part of 'rosas_model.dart';

enum RosasSourceFrom { feedly }

class RosasSource extends Equatable {
  final RosasSourceFrom source;
  final String url;
  final String title;
  final Iterable<RosasTopic> topics;
  final String iconUrl;
  final List<RosasArticle> articles;

  const RosasSource(this.source, this.url, this.title, this.topics, this.iconUrl,
      {this.articles = const []});

  @override
  List<Object?> get props => [title, url, iconUrl];

  Future<RosasSource> fetchArticles() async {
    if (source == RosasSourceFrom.feedly) {
      final fetchedArticles = await Feedly.getSourceArticles(this);
      return copyWith(articles: [...{...fetchedArticles.toList()}]);
    } else {
      return this;
    }
  }

  RosasSource copyWith({
    String? url,
    String? title,
    Iterable<RosasTopic>? topics,
    String? iconUrl,
    List<RosasArticle>? articles,
  }) {
    return RosasSource(
        source,
        url ?? this.url,
        title ?? this.title,
        topics ?? this.topics,
        iconUrl ?? this.iconUrl,
        articles: articles ?? this.articles);
  }
}
