import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/services/services_barrel.dart';

class SearchRepository {
  String _term = '';
  List<RosasSource> _results = [];

  SearchRepository();

  String getTerm() => _term;

  void changeTerm(String term) => _term = term;

  List<RosasSource> getResults() => _results;

  Future<void> fetchResults() async {
    _results = (await Feedly.searchSource(_term)).toList();
  }
}
