part of 'search_bloc.dart';

enum SearchStatus { initial, success, error, loading }

extension SearchStatusX on SearchStatus {
  bool get isInitial => this == SearchStatus.initial;

  bool get isSuccess => this == SearchStatus.success;

  bool get isError => this == SearchStatus.error;

  bool get isLoading => this == SearchStatus.loading;
}

class SearchState extends Equatable {
  final SearchStatus status;
  final List<RosasSource> results;
  final String term;

  const SearchState(
      {this.status = SearchStatus.initial,
      this.results = const [],
      this.term = ''});

  @override
  List<Object?> get props => [status, results, term];

  SearchState copyWith({
    List<RosasSource>? results,
    String? term,
    SearchStatus? status,
  }) {
    return SearchState(
        status: status ?? this.status,
        results: results ?? this.results,
        term: term ?? this.term);
  }
}
