part of 'rosas_model.dart';

enum RosasNotificationType { article }

class RosasNotification extends Equatable {
  final RosasNotificationType type;
  final RosasArticle? article;
  final bool read;

  const RosasNotification (this.type, {this.article, this.read = false});

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
    return RosasNotification(
        type,
        article: article,
        read: read ?? this.read);
  }
}
