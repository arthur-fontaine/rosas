import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchRepository searchRepository;

  SearchBloc({required this.searchRepository})
      : super(const SearchState()) {
    on<GetTerm>(_mapGetTermEventToState);
    on<ChangeTerm>(_mapChangeTermEventToState);
    on<GetResults>(_mapGetResultsEventToState);
    on<FetchResults>(_mapFetchResultsEventToState);
  }

  void _mapGetTermEventToState(GetTerm event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      emit(state.copyWith(
          status: SearchStatus.success,
          term: searchRepository.getTerm()));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.error));
    }
  }

  void _mapChangeTermEventToState(ChangeTerm event, Emitter<SearchState> emit) {
    searchRepository.changeTerm(event.term);
    add(GetTerm());
    add(FetchResults());
  }

  void _mapGetResultsEventToState(GetResults event, Emitter<SearchState> emit) {
    emit(state.copyWith(status: SearchStatus.loading));

    try {
      emit(state.copyWith(
          status: SearchStatus.success,
          results: searchRepository.getResults()));
    } catch (e) {
      emit(state.copyWith(status: SearchStatus.error));
    }
  }

  void _mapFetchResultsEventToState(FetchResults event, Emitter<SearchState> emit) async {
    await searchRepository.fetchResults();
    add(GetResults());
  }
}
