import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/services_barrel.dart';

void fetchFromLocal(BuildContext context) async {
  final notificationsBloc = context.read<NotificationsBloc>();
  final readLaterBloc = context.read<ReadLaterBloc>();
  final subscribedSourcesBloc = context.read<SubscribedSourcesBloc>();

  final readLaterRaw = await LocalStorage.loadRawReadLater();
  final notificationsSubscribedRaw =
      await LocalStorage.loadRawNotificationsSubscribed();
  final notificationsRaw = await LocalStorage.loadRawNotifications();
  final subscribedSourcesRaw = await LocalStorage.loadRawSubscribedSources();

  if (notificationsRaw != null) {
    final notifications = jsonDecode(notificationsRaw);
    for (var notification in notifications) {
      notificationsBloc
          .add(AddNotification(RosasNotification.fromJSON(notification)));
    }
  }

  if (notificationsSubscribedRaw != null) {
    final notificationsSubscribed = jsonDecode(notificationsSubscribedRaw);
    for (var notificationSubscribed in notificationsSubscribed) {
      notificationsBloc.add(
          SubscribeNotification(RosasSource.fromJSON(notificationSubscribed)));
    }
  }

  if (readLaterRaw != null) {
    final readLater = jsonDecode(readLaterRaw);
    for (var readLaterArticle in readLater) {
      readLaterBloc
          .add(AddReadLaterArticle(RosasArticle.fromJSON(readLaterArticle)));
    }
  }

  if (subscribedSourcesRaw != null) {
    final subscribedSources = jsonDecode(subscribedSourcesRaw);
    for (var subscribedSource in subscribedSources) {
      subscribedSourcesBloc
          .add(SubscribeSource(RosasSource.fromJSON(subscribedSource)));
    }
  }
}
