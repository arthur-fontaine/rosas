part of 'notifications_bloc.dart';

enum NotificationsStatus { initial, success, error, loading }

extension NotificationsStatusX on NotificationsStatus {
  bool get isInitial => this == NotificationsStatus.initial;

  bool get isSuccess => this == NotificationsStatus.success;

  bool get isError => this == NotificationsStatus.error;

  bool get isLoading => this == NotificationsStatus.loading;
}

class NotificationsState extends Equatable {
  final NotificationsStatus status;
  final List<RssItem> notifications;

  const NotificationsState(
      {this.status = NotificationsStatus.initial, this.notifications = const []});

  @override
  List<Object?> get props => [status, notifications];

  NotificationsState copyWith({
    List<RssItem>? notifications,
    NotificationsStatus? status,
  }) {
    return NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications);
  }
}
