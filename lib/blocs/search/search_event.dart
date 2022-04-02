part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTerm extends SearchEvent {}

class ChangeTerm extends SearchEvent {
  final String term;

  ChangeTerm(this.term);

  @override
  List<Object?> get props => [term];
}

class GetResults extends SearchEvent {}

class FetchResults extends SearchEvent {}
