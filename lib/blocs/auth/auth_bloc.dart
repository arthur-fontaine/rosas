import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rosas/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthRepository authRepository;

  AuthBloc({required this.authRepository})
      : super(const AuthState()) {
    on<GetUser>(_mapGetUserEventToState);
    on<ChangeUser>(_mapChangeUserEventToState);
    on<UnsetUser>(_mapUnsetUserEventToState);
  }

  void _mapGetUserEventToState(GetUser event, Emitter<AuthState> emit) {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      final user = authRepository.getUser();
      emit(state.copyWith(
          status: user != null ? AuthStatus.loggedIn : AuthStatus.loggedOut,
          user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.error));
    }
  }

  void _mapChangeUserEventToState(ChangeUser event, Emitter<AuthState> emit) {
    authRepository.changeUser(event.user);
    add(GetUser());
  }

  void _mapUnsetUserEventToState(UnsetUser event, Emitter<AuthState> emit) {
    authRepository.unsetUser();
    add(GetUser());
  }
}
