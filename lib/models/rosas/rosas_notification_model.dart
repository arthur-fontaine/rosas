part of 'rosas_model.dart';

enum RosasNotificationType { article }

class RosasNotification extends Equatable {
  final RosasNotificationType type;
  final RosasArticle? article;
  final bool read;

  const RosasNotification (this.type, {this.article, this.read = false});

  @override
  List<Object?> get props => [article];

  RosasNotification copyWith({
    bool? read,
  }) {
    return RosasNotification(
        type,
        article: article,
        read: read ?? this.read);
  }
}
