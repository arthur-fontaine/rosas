part of 'rosas_model.dart';

enum RosasNotificationType { article }

extension RosasNotificationTypeX on RosasNotificationType {
  String toJSON() {
    switch (this) {
      case RosasNotificationType.article:
        return 'article';
    }
  }
}

RosasNotificationType rosasNotificationTypeFromJSON(String rosasSourceFrom) {
  switch (rosasSourceFrom) {
    case 'article':
      return RosasNotificationType.article;
    default:
      return RosasNotificationType.article;
  }
}

class RosasNotification extends Equatable {
  final RosasNotificationType type;
  final RosasArticle? article;
  final bool read;

  const RosasNotification(this.type, {this.article, this.read = false});

  @override
  List<Object?> get props => [article, type, read];

  DateTime get published {
    if (type == RosasNotificationType.article && article != null) {
      return article!.published;
    } else {
      return DateTime.now();
    }
  }

  RosasNotification copyWith({
    bool? read,
  }) {
    return RosasNotification(type, article: article, read: read ?? this.read);
  }

  factory RosasNotification.fromJSON(Map<String, dynamic> json) {
    return RosasNotification(rosasNotificationTypeFromJSON(json['type']),
        article: RosasArticle.fromJSON(json['article']), read: json['read']);
  }

  Map<String, dynamic> toJSON() {
    return {
      'type': type.toJSON(),
      'article': article?.toJSON(),
      'read': read
    };
  }
}
