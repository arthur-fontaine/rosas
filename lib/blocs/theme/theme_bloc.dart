import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/ui/themes/themes_barrel.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeRepository themeRepository;

  ThemeBloc({required this.themeRepository}) : super(ThemeState()) {
    on<GetThemeData>(_mapGetThemeDataEventToState);
    on<SetThemeData>(_mapSetThemeDataEventToState);
  }

  void _mapGetThemeDataEventToState(
      GetThemeData event, Emitter<ThemeState> emit) {
    emit(state.copyWith(status: ThemeStatus.loading));

    try {
      emit(state.copyWith(
          status: ThemeStatus.success,
          themeData: themeRepository.getThemeData()));
    } catch (e) {
      emit(state.copyWith(status: ThemeStatus.error));
    }
  }

  void _mapSetThemeDataEventToState(SetThemeData event, Emitter<ThemeState> emit) {
    themeRepository.setThemeData(event.themeData);
    add(GetThemeData());
  }
}
