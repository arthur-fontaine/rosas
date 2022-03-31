import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'subscribed_feeds_event.dart';
part 'subscribed_feeds_state.dart';

class SubscribedFeedsBloc extends Bloc<SubscribedFeedsEvent, SubscribedFeedsState> {
  final FeedsRepository feedsRepository;

  SubscribedFeedsBloc({required this.feedsRepository})
      : super(const SubscribedFeedsState()) {
    on<GetSubscribedFeeds>(_mapGetSubscribedFeedsEventToState);
    on<UnsubscribeFeed>(_mapUnsubscribeFeedEventToState);
  }

  void _mapGetSubscribedFeedsEventToState(
      GetSubscribedFeeds event, Emitter<SubscribedFeedsState> emit) async {
    emit(state.copyWith(status: SubscribedFeedsStatus.loading));

    try {
      final subscribedFeeds = await feedsRepository.getSubscribedFeed();

      emit(state.copyWith(
        status: SubscribedFeedsStatus.success,
        subscribedFeeds: subscribedFeeds,
      ));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }

      emit(state.copyWith(status: SubscribedFeedsStatus.error));
    }
  }

  void _mapUnsubscribeFeedEventToState(UnsubscribeFeed event, Emitter<SubscribedFeedsState> emit) {
    feedsRepository.unsubscribeFeed(event.feed);
    add(GetSubscribedFeeds());
  }
}
