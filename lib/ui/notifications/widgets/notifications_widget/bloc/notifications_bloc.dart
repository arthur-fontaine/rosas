import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsRepository notificationsRepository;
  final FeedsRepository feedsRepository;

  NotificationsBloc(
      {required this.notificationsRepository, required this.feedsRepository})
      : super(const NotificationsState()) {
    on<GetNotifications>(_mapGetNotificationsEventToState);
    on<SubscribeToNotifications>(_mapSubscribeToNotificationsEventToState);
    on<UnsubscribeToNotifications>(_mapUnsubscribeToNotificationsEventToState);
    on<OpenNotificationsPage>(_mapOpenNotificationsPageEventToState);
  }

  void _mapGetNotificationsEventToState(
      GetNotifications event, Emitter<NotificationsState> emit) async {
    emit(state.copyWith(status: NotificationsStatus.loading));

    try {
      final notifications = await feedsRepository.getNotifications();
      final lastNotificationsRead =
          await notificationsRepository.getLastNotificationsRead();

      emit(state.copyWith(
        status: NotificationsStatus.success,
        notifications: notifications
            .where((notification) =>
                lastNotificationsRead == null ||
                (notification.pubDate?.isAfter(lastNotificationsRead) ??
                    false))
            .toList(),
      ));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }

      emit(state.copyWith(status: NotificationsStatus.error));
    }
  }

  void _mapSubscribeToNotificationsEventToState(
      SubscribeToNotifications event, Emitter<NotificationsState> emit) {
    feedsRepository.addFeedTobeNotified(event.feed);
    add(GetNotifications());
  }

  void _mapUnsubscribeToNotificationsEventToState(
      UnsubscribeToNotifications event, Emitter<NotificationsState> emit) {
    feedsRepository.removeFeedTobeNotified(event.feed);
    add(GetNotifications());
  }

  void _mapOpenNotificationsPageEventToState(OpenNotificationsPage event, Emitter<NotificationsState> emit) {
    notificationsRepository.setLastNotificationsRead(DateTime.now());
  }
}
