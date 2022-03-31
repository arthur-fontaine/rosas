part of 'search_bar_bloc.dart';

enum SearchBarStatus { initial, empty, notEmpty, error }

extension SearchBarStatusX on SearchBarStatus {
  bool get isInitial => this == SearchBarStatus.initial;

  bool get isEmpty => this == SearchBarStatus.empty;

  bool get isNotEmpty => this == SearchBarStatus.notEmpty;

  bool get isError => this == SearchBarStatus.error;
}

class SearchBarState extends Equatable {
  final SearchBarStatus status;
  final String searchTerm;

  const SearchBarState(
      {this.status = SearchBarStatus.initial, this.searchTerm = ""});

  @override
  List<Object?> get props => [status, searchTerm];

  SearchBarState copyWith({
    String? searchTerm,
    SearchBarStatus? status,
  }) {
    return SearchBarState(
      status: status ?? this.status,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}
