import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rosas/blocs/blocs_barrel.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/services_barrel.dart';

void fetchFromCloud(BuildContext context, User user) async {
  final notificationsBloc = context.read<NotificationsBloc>();
  final readLaterBloc = context.read<ReadLaterBloc>();
  final subscribedSourcesBloc = context.read<SubscribedSourcesBloc>();

  final doc = users.doc(user.uid);
  final data = await doc.get();

  final readLater = data['readLater'];
  final notificationsSubscribed = data['notificationsSubscribed'];
  final subscribedSources = data['subscribedSources'];

  if (notificationsSubscribed is List<dynamic>) {
    for (var notificationSubscribed in notificationsSubscribed) {
      notificationsBloc.add(
          AddNotification(RosasNotification.fromJSON(notificationSubscribed)));
    }
  }

  if (readLater is List<dynamic>) {
    for (var readLaterArticle in readLater) {
      readLaterBloc
          .add(AddReadLaterArticle(RosasArticle.fromJSON(readLaterArticle)));
    }
  }

  if (subscribedSources is List<dynamic>) {
    for (var subscribedSource in subscribedSources) {
      subscribedSourcesBloc
          .add(SubscribeSource(RosasSource.fromJSON(subscribedSource)));
    }
  }
}
