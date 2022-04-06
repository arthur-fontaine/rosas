import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository notificationsRepository;

  NotificationsBloc({required this.notificationsRepository})
      : super(const NotificationsState()) {
    on<GetNotifications>(_mapGetNotificationsEventToState);
    on<SetNotifications>(_mapSetNotificationsEventToState);
    on<AddNotification>(_mapAddNotificationEventToState);
    on<RemoveNotification>(_mapRemoveNotificationEventToState);
    on<SubscribeNotification>(_mapSubscribeNotificationEventToState);
    on<UnsubscribeNotification>(_mapUnsubscribeNotificationEventToState);
    on<FetchNotifications>(_mapFetchNotificationsEventToState);
    on<ReadNotification>(_mapReadNotificationEventToState);
    on<UnreadNotification>(_mapUnreadNotificationsEventToState);
    on<ReadAllNotifications>(_mapReadAllNotificationsEventToState);
    on<UnreadAllNotifications>(_mapUnreadAllNotificationsEventToState);
    on<GetSubscribedNotificationsSources>(_mapGetSubscribedNotificationsSourcesEventToState);
  }

  void _mapGetNotificationsEventToState(GetNotifications event,
      Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: NotificationsStatus.loading));

    try {
      emit(state.copyWith(
          status: NotificationsStatus.success,
          notifications: notificationsRepository.getNotifications()
      ));
    } catch (e) {
      emit(state.copyWith(status: NotificationsStatus.error));
    }
  }

  void _mapSetNotificationsEventToState(SetNotifications event, Emitter<NotificationsState> emit) {
    notificationsRepository.setNotifications(event.notifications);
    add(GetNotifications());
  }

  void _mapAddNotificationEventToState(AddNotification event, Emitter<NotificationsState> emit) {
    notificationsRepository.addNotification(event.notification);
    add(GetNotifications());
  }

  void _mapRemoveNotificationEventToState(RemoveNotification event, Emitter<NotificationsState> emit) {
    notificationsRepository.removeNotification(event.notification);
    add(GetNotifications());
  }

  void _mapSubscribeNotificationEventToState(SubscribeNotification event, Emitter<NotificationsState> emit) {
    notificationsRepository.subscribe(event.source);
    add(GetSubscribedNotificationsSources());
  }

  void _mapUnsubscribeNotificationEventToState(UnsubscribeNotification event, Emitter<NotificationsState> emit) {
    notificationsRepository.unsubscribe(event.source);
    add(GetSubscribedNotificationsSources());
  }

  void _mapFetchNotificationsEventToState(FetchNotifications event, Emitter<NotificationsState> emit) {
    notificationsRepository.fetchNotifications();
    add(GetNotifications());
  }

  void _mapReadNotificationEventToState(ReadNotification event, Emitter<NotificationsState> emit) {
    notificationsRepository.read(event.notification);
    add(GetNotifications());
  }

  void _mapUnreadNotificationsEventToState(UnreadNotification event, Emitter<NotificationsState> emit) {
    notificationsRepository.unread(event.notification);
    add(GetNotifications());
  }

  void _mapReadAllNotificationsEventToState(ReadAllNotifications event, Emitter<NotificationsState> emit) {
    notificationsRepository.readAll();
    add(GetNotifications());
  }

  void _mapUnreadAllNotificationsEventToState(UnreadAllNotifications event, Emitter<NotificationsState> emit) {
    notificationsRepository.unreadAll();
    add(GetNotifications());
  }

  void _mapGetSubscribedNotificationsSourcesEventToState(GetSubscribedNotificationsSources event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: NotificationsStatus.loading));

    try {
      emit(state.copyWith(
          status: NotificationsStatus.success,
          subscribedSources: notificationsRepository.getSubscribedSources()
      ));
    } catch (e) {
      emit(state.copyWith(status: NotificationsStatus.error));
    }
  }
}
