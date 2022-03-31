import 'package:rosas/firebase/firebase_barrel.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/utils/utils_barrel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsRepository {
  NotificationsRepository();

  Future<DateTime?> getLastNotificationsRead() async {
    final prefs = await SharedPreferences.getInstance();
    final lastNotificationsReadTimeStamp =
        prefs.getInt('last_notifications_read');

    if (lastNotificationsReadTimeStamp == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(lastNotificationsReadTimeStamp);
  }

  void setLastNotificationsRead(DateTime dateTime) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('last_notifications_read', dateTime.millisecondsSinceEpoch);
  }
}
