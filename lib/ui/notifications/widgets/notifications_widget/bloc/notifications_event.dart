part of 'notifications_bloc.dart';

class NotificationsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetNotifications extends NotificationsEvent {}

class SubscribeToNotifications extends NotificationsEvent {
  final RssFeed feed;

  SubscribeToNotifications({
    required this.feed,
  });

  @override
  List<Object?> get props => [feed];
}

class UnsubscribeToNotifications extends NotificationsEvent {
  final RssFeed feed;

  UnsubscribeToNotifications({
    required this.feed,
  });

  @override
  List<Object?> get props => [feed];
}

class OpenNotificationsPage extends NotificationsEvent {
  @override
  List<Object?> get props => [];
}
