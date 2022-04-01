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
  final List<RosasNotification> notifications;
  final List<RosasSource> subscribedSources;

  const NotificationsState(
      {this.status = NotificationsStatus.initial,
      this.notifications = const [],
      this.subscribedSources = const []});

  @override
  List<Object?> get props => [status, notifications];

  NotificationsState copyWith({
    List<RosasNotification>? notifications,
    List<RosasSource>? subscribedSources,
    NotificationsStatus? status,
  }) {
    return NotificationsState(
        status: status ?? this.status,
        notifications: notifications ?? this.notifications,
        subscribedSources: subscribedSources ?? this.subscribedSources);
  }
}
