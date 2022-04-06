import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class _User extends Equatable {
  final User user;

  const _User(this.user);

  @override
  List<Object?> get props => [user.uid, user.email, user.isAnonymous];
}

class AuthRepository {
  _User? _user;

  AuthRepository();

  User? getUser() => _user?.user;

  void changeUser(User user) => _user = _User(user);

  void unsetUser() => _user = null;
}
