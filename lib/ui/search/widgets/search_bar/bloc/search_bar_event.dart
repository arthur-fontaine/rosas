part of 'search_bar_bloc.dart';

class SearchBarEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SetSearchTerm extends SearchBarEvent {
  final String searchTerm;

  SetSearchTerm({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}
