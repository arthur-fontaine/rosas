part of 'auth_bloc.dart';

class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUser extends AuthEvent {}

class ChangeUser extends AuthEvent {
  final User user;

  ChangeUser(this.user);

  @override
  List<Object?> get props => [user];
}

class UnsetUser extends AuthEvent {}
