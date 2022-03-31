part of 'subscribed_feeds_bloc.dart';

enum SubscribedFeedsStatus { initial, success, error, loading }

extension SubscribedFeedsStatusX on SubscribedFeedsStatus {
  bool get isInitial => this == SubscribedFeedsStatus.initial;

  bool get isSuccess => this == SubscribedFeedsStatus.success;

  bool get isError => this == SubscribedFeedsStatus.error;

  bool get isLoading => this == SubscribedFeedsStatus.loading;
}

class SubscribedFeedsState extends Equatable {
  final SubscribedFeedsStatus status;
  final Iterable<RssFeed> subscribedFeeds;

  const SubscribedFeedsState(
      {this.status = SubscribedFeedsStatus.initial, this.subscribedFeeds = const []});

  @override
  List<Object?> get props => [status, subscribedFeeds];

  SubscribedFeedsState copyWith({
    Iterable<RssFeed>? subscribedFeeds,
    SubscribedFeedsStatus? status,
  }) {
    return SubscribedFeedsState(
      status: status ?? this.status,
      subscribedFeeds: subscribedFeeds ?? this.subscribedFeeds,
    );
  }
}
