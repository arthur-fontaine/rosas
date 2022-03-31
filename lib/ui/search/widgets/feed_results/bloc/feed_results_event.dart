part of 'feed_results_bloc.dart';

class FeedResultsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetFeedResults extends FeedResultsEvent {
  final String searchTerm;

  GetFeedResults({
    required this.searchTerm,
  });

  @override
  List<Object?> get props => [searchTerm];
}

class SubscribeFeed extends FeedResultsEvent {
  final RssFeed feed;

  SubscribeFeed({
    required this.feed,
  });

  @override
  List<Object?> get props => [feed];
}

class UnsubscribeFeed extends FeedResultsEvent {
  final RssFeed feed;

  UnsubscribeFeed({
    required this.feed,
  });

  @override
  List<Object?> get props => [feed];
}
