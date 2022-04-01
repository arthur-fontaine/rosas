part of 'notifications_bloc.dart';

class NotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNotifications extends NotificationsEvent {}

class SetNotifications extends NotificationsEvent {
  final List<RosasNotification> notifications;

  SetNotifications(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

class AddNotification extends NotificationsEvent {
  final RosasNotification notification;

  AddNotification(this.notification);

  @override
  List<Object?> get props => [notification];
}

class RemoveNotification extends NotificationsEvent {
  final RosasNotification notification;

  RemoveNotification(this.notification);

  @override
  List<Object?> get props => [notification];
}

class SubscribeNotification extends NotificationsEvent {
  final RosasSource source;

  SubscribeNotification(this.source);

  @override
  List<Object?> get props => [source];
}

class UnsubscribeNotification extends NotificationsEvent {
  final RosasSource source;

  UnsubscribeNotification(this.source);

  @override
  List<Object?> get props => [source];
}

class FetchNotifications extends NotificationsEvent {}

class ReadNotification extends NotificationsEvent {
  final RosasNotification notification;

  ReadNotification(this.notification);

  @override
  List<Object?> get props => [notification];
}

class UnreadNotification extends NotificationsEvent {
  final RosasNotification notification;

  UnreadNotification(this.notification);

  @override
  List<Object?> get props => [notification];
}

class ReadAllNotifications extends NotificationsEvent {}

class UnreadAllNotifications extends NotificationsEvent {}
