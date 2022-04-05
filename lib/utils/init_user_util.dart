import 'package:firebase_auth/firebase_auth.dart';
import 'package:rosas/services/services_barrel.dart';

void initUser(User user) {
    users.doc(user.uid).set({
      'subscribedSources': [],
      'notificationsSubscribed': [],
      'readLater': [],
      'notifications': [],
    });
}
