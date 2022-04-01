part of 'read_later_bloc.dart';

enum ReadLaterStatus { initial, success, error, loading }

extension ReadLaterStatusX on ReadLaterStatus {
  bool get isInitial => this == ReadLaterStatus.initial;

  bool get isSuccess => this == ReadLaterStatus.success;

  bool get isError => this == ReadLaterStatus.error;

  bool get isLoading => this == ReadLaterStatus.loading;
}

class ReadLaterState extends Equatable {
  final ReadLaterStatus status;
  final List<RosasArticle> articles;

  const ReadLaterState(
      {this.status = ReadLaterStatus.initial,
        this.articles = const []});

  @override
  List<Object?> get props => [status, articles];

  ReadLaterState copyWith({
    List<RosasArticle>? articles,
    ReadLaterStatus? status,
  }) {
    return ReadLaterState(
        status: status ?? this.status,
        articles: articles ?? this.articles);
  }
}
