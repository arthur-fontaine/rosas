part of 'rosas_model.dart';

enum RosasSourceFrom { feedly }

class RosasSource extends Equatable {
  final RosasSourceFrom source;
  final String url;
  final String title;
  final Iterable<RosasTopic> topics;
  final List<RosasArticle>? articles;

  const RosasSource(this.source, this.url, this.title, this.topics, {this.articles});

  @override
  List<Object?> get props => [title, url];
}
