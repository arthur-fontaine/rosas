import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rosas/services/services_barrel.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';
import 'package:rosas/utils/fetch_feed_util.dart';

part 'feed_results_event.dart';

part 'feed_results_state.dart';

class FeedResultsBloc extends Bloc<FeedResultsEvent, FeedResultsState> {
  final FeedsRepository feedsRepository;

  FeedResultsBloc({required this.feedsRepository})
      : super(const FeedResultsState()) {
    on<GetFeedResults>(_mapGetFeedResultsEventToState);
    on<SubscribeFeed>(_mapSubscribeFeedEventToState);
    on<UnsubscribeFeed>(_mapUnsubscribeFeedEventToState);
  }

  void _mapGetFeedResultsEventToState(
      GetFeedResults event, Emitter<FeedResultsState> emit) async {
    emit(state.copyWith(status: FeedResultsStatus.loading));

    try {
      final customFeedUrlPattern = RegExp(
          r'https?://(www.)?[-a-zA-Z0-9@:%._+~#=]{1,256}.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_+.~#?&//=]*)');

      late final Iterable<RssFeed> feedResults;

      if (customFeedUrlPattern.hasMatch(event.searchTerm)) {
        feedResults = [await fetchFeed(event.searchTerm)];
      } else {
        feedResults = await Feedly.searchFeeds(event.searchTerm);
        final subscribedFeedsUrl = await feedsRepository
            .getSubscribedFeedUrls();

        for (var feedResult in feedResults) {
          feedResult.subscribed = subscribedFeedsUrl.contains(feedResult.link);
        }
      }

      emit(state.copyWith(
        status: FeedResultsStatus.success,
        feedResults: feedResults,
      ));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }

      emit(state.copyWith(status: FeedResultsStatus.error));
    }
  }

  void _mapSubscribeFeedEventToState(
      SubscribeFeed event, Emitter<FeedResultsState> emit) {
    feedsRepository.subscribeFeed(event.feed);
  }

  void _mapUnsubscribeFeedEventToState(
      UnsubscribeFeed event, Emitter<FeedResultsState> emit) {
    feedsRepository.unsubscribeFeed(event.feed);
  }
}
