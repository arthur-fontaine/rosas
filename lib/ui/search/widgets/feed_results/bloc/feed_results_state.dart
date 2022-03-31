part of 'feed_results_bloc.dart';

enum FeedResultsStatus { initial, success, error, loading }

extension FeedResultsStatusX on FeedResultsStatus {
  bool get isInitial => this == FeedResultsStatus.initial;

  bool get isSuccess => this == FeedResultsStatus.success;

  bool get isError => this == FeedResultsStatus.error;

  bool get isLoading => this == FeedResultsStatus.loading;
}

class FeedResultsState extends Equatable {
  final FeedResultsStatus status;
  final Iterable<RssFeed> feedResults;

  const FeedResultsState(
      {this.status = FeedResultsStatus.initial, this.feedResults = const []});

  @override
  List<Object?> get props => [status, feedResults];

  FeedResultsState copyWith({
    Iterable<RssFeed>? feedResults,
    FeedResultsStatus? status,
  }) {
    return FeedResultsState(
      status: status ?? this.status,
      feedResults: feedResults ?? this.feedResults,
    );
  }
}
