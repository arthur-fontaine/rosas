part of 'subscribed_feeds_bloc.dart';

class SubscribedFeedsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSubscribedFeeds extends SubscribedFeedsEvent {
  GetSubscribedFeeds();

  @override
  List<Object?> get props => [];
}

class UnsubscribeFeed extends SubscribedFeedsEvent {
  final RssFeed feed;

  UnsubscribeFeed({
    required this.feed,
  });

  @override
  List<Object?> get props => [feed];
}
