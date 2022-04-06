import 'dart:convert';

import 'package:rosas/models/rosas/rosas_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static void saveData({
    List<RosasSource>? subscribedSources,
    List<RosasSource>? notificationsSubscribed,
    List<RosasNotification>? notifications,
    List<RosasArticle>? readLater,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (subscribedSources != null) {
      prefs.setString(
          'subscribedSources',
          jsonEncode(
              subscribedSources.map((source) => source.toJSON()).toList()));
    }

    if (notificationsSubscribed != null) {
      prefs.setString(
          'notificationsSubscribed',
          jsonEncode(notificationsSubscribed
              .map((source) => source.toJSON())
              .toList()));
    }

    if (notifications != null) {
      prefs.setString('notifications',
          jsonEncode(notifications.map((notification) {
        if (notification.article != null) {
          notification.article!.toJSON();
        }
      })));
    }

    if (readLater != null) {
      prefs.setString('readLater',
          jsonEncode(readLater.map((article) => article.toJSON()).toList()));
    }
  }

  static Future<String?> loadRawSubscribedSources() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('subscribedSources');
  }

  static Future<String?> loadRawNotificationsSubscribed() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('notificationsSubscribed');
  }

  static Future<String?> loadRawNotifications() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('notifications');
  }

  static Future<String?> loadRawReadLater() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('readLater');
  }
}
