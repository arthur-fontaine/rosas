part of 'auth_bloc.dart';

enum AuthStatus { initial, loggedIn, loggedOut, error, loading }

extension AuthStatusX on AuthStatus {
  bool get isInitial => this == AuthStatus.initial;

  bool get isLoggedIn => this == AuthStatus.loggedIn;

  bool get isLoggedOut => this == AuthStatus.loggedOut;

  bool get isSuccess => isLoggedIn || isLoggedOut;

  bool get isError => this == AuthStatus.error;

  bool get isLoading => this == AuthStatus.loading;
}

class AuthState extends Equatable {
  final AuthStatus status;
  final User? user;

  const AuthState(
      {this.status = AuthStatus.initial,
        this.user});

  @override
  List<Object?> get props => [status, user];

  AuthState copyWith({
    User? user,
    AuthStatus? status,
  }) {
    return AuthState(
        status: status ?? this.status,
        user: user);
  }
}
