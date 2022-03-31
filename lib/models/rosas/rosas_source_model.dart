part of 'rosas_model.dart';

enum RosasSourceFrom { feedly }

class RosasSource {
  RosasSourceFrom source;
  String url;
  String title;
  Iterable<RosasTopic> topics;
  List<RosasArticle>? articles;

  RosasSource(this.source, this.url, this.title, this.topics, {this.articles});
}
