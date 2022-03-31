import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'search_bar_event.dart';

part 'search_bar_state.dart';

class SearchBarBloc extends Bloc<SearchBarEvent, SearchBarState> {
  final SearchRepository searchRepository;

  SearchBarBloc({required this.searchRepository})
      : super(const SearchBarState()) {
    on<SetSearchTerm>(_mapSetSearchTermEventToState);
  }

  void _mapSetSearchTermEventToState(
      SetSearchTerm event, Emitter<SearchBarState> emit) {
    try {
      searchRepository.setSearchTerm(event.searchTerm);

      emit(state.copyWith(
        status: event.searchTerm.isNotEmpty
            ? SearchBarStatus.notEmpty
            : SearchBarStatus.empty,
        searchTerm: searchRepository.getSearchTerm(),
      ));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }

      emit(state.copyWith(status: SearchBarStatus.error));
    }
  }
}
