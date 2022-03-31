class SearchRepository {
  String _searchTerm = "";
  final List<String> _searchHistory = [];

  SearchRepository();

  String getSearchTerm() => _searchTerm;

  void setSearchTerm(String searchTerm) => _searchTerm = searchTerm;

  List<String> getSearchHistory() => _searchHistory;

  void addSearchTermInHistory() => _searchHistory.add(_searchTerm);
}
