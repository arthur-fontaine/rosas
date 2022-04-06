import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/services_barrel.dart';

class NotificationsRepository {
  List<RosasNotification> _notifications = [];
  final List<RosasSource> _subscribedSources = [];

  NotificationsRepository();

  List<RosasSource> getSubscribedSources() => _subscribedSources;

  List<RosasNotification> getNotifications() =>
      _notifications.where((notification) => !notification.read).toList();

  void setNotifications(List<RosasNotification> notifications) =>
      _notifications = notifications;

  void addNotification(RosasNotification notification) {
    if (!_notifications.contains(notification)) {
      _notifications.add(notification);
    }
  }

  void removeNotification(RosasNotification notification) =>
      _notifications.remove(notification);

  void subscribe(RosasSource source) async {
    if (!_subscribedSources.contains(source)) {
      _subscribedSources.add(source);

      final sourceArticles = await Feedly.getSourceArticles(source);
      _notifications.addAll(sourceArticles.map((article) =>
          RosasNotification(
              RosasNotificationType.article,
              article: article,
              read: true)));

      if (auth.currentUser != null) {
        users.doc(auth.currentUser?.uid).update({
          "notificationsSubscribed": FieldValue.arrayUnion([source.toJSON()])
        });
      }
    }
  }

  void unsubscribe(RosasSource source) {
    _subscribedSources.remove(source);

    if (auth.currentUser != null) {
      users.doc(auth.currentUser?.uid).update({
        "notificationsSubscribed": FieldValue.arrayRemove([source.toJSON()])
      });
    }
  }

  void fetchNotifications() async {
    final articles = (await Future.wait(_subscribedSources.map((source) {
      return Feedly.getSourceArticles(source);
    })))
        .expand((i) => i)
        .where((article) => !_notifications
            .map((notification) => notification.article)
            .contains(article));

    for (var article in articles) {
      addNotification(
          RosasNotification(RosasNotificationType.article, article: article));

      users.doc(auth.currentUser?.uid).update({
        "notifications": FieldValue.arrayUnion([article.toJSON()])
      });
    }
  }

  void _updateRead(RosasNotification notification, bool read) {
    final foundNotificationIndex =
        _notifications.indexWhere((element) => element == notification);
    final foundNotification = _notifications[foundNotificationIndex];

    final updatedNotification = foundNotification.copyWith(read: read);

    if (notification.article != null) {
      users.doc(auth.currentUser?.uid).update({
        "notifications": FieldValue.arrayUnion([notification.article!.toJSON()])
      });
    }

    _notifications.removeAt(foundNotificationIndex);
    _notifications.insert(foundNotificationIndex, updatedNotification);
  }

  void read(RosasNotification notification) {
    _updateRead(notification, true);
  }

  void unread(RosasNotification notification) {
    _updateRead(notification, false);
  }

  void readAll() {
    for (var notification in _notifications) {
      read(notification);
    }
  }

  void unreadAll() {
    for (var notification in _notifications) {
      unread(notification);
    }
  }
}
