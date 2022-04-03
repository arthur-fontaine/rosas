import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  User? _user;

  AuthRepository();

  User? getUser() => _user;

  void changeUser(User user) => _user = user;

  void unsetUser() => _user = null;
}
