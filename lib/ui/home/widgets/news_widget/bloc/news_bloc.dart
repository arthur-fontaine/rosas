import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:rosas/utils/utils_barrel.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final FeedsRepository feedsRepository;

  NewsBloc({required this.feedsRepository}) : super(const NewsState()) {
    on<GetSubscribedNews>(_mapGetSubscribedNewsEventToState);
  }

  void _mapGetSubscribedNewsEventToState(
      GetSubscribedNews event, Emitter<NewsState> emit) async {
    emit(state.copyWith(status: NewsStatus.loading));

    try {
      final subscribedFeedUrls = await feedsRepository.getSubscribedFeedUrls();
      final news = (await Future.wait(subscribedFeedUrls
              .map((subscribedFeedUrl) => fetchFeed(subscribedFeedUrl))))
          .map((feed) => feed.items?.toList())
          .whereType<List<RssItem>>()
          .flatten<RssItem>()
          .toList();

      emit(state.copyWith(
        status: NewsStatus.success,
        news: news,
      ));
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print(stacktrace);
      }

      emit(state.copyWith(status: NewsStatus.error));
    }
  }
}
