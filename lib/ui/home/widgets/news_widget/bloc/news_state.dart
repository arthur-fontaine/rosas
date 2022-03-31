part of 'news_bloc.dart';

enum NewsStatus { initial, success, error, loading }

extension NewsStatusX on NewsStatus {
  bool get isInitial => this == NewsStatus.initial;
  bool get isSuccess => this == NewsStatus.success;
  bool get isError => this == NewsStatus.error;
  bool get isLoading => this == NewsStatus.loading;
}

class NewsState extends Equatable {
  final NewsStatus status;
  final List<RssItem> news;

  const NewsState({this.status = NewsStatus.initial, this.news = const []});

  @override
  List<Object?> get props => [status, news];

  NewsState copyWith({
    List<RssItem>? news,
    NewsStatus? status,
  }) {
    return NewsState(
      status: status ?? this.status,
      news: news ?? this.news
    );
  }
}
