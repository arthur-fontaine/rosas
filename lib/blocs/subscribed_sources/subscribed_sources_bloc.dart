import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'subscribed_sources_event.dart';

part 'subscribed_sources_state.dart';

class SubscribedSourcesBloc
    extends Bloc<SubscribedSourcesEvent, SubscribedSourcesState> {
  SubscribedSourcesRepository subscribedSourcesRepository;

  SubscribedSourcesBloc({required this.subscribedSourcesRepository})
      : super(const SubscribedSourcesState()) {
    on<GetSubscribedSources>(_mapGetSubscribedSourcesEventToState);
    on<SubscribeSource>(_mapSubscribeSourceEventToState);
    on<UnsubscribeSource>(_mapUnsubscribeSourceEventToState);
    on<ToggleSubscriptionSource>(_mapToggleSubscriptionSourceEventToState);
    on<FetchNews>(_mapFetchNewsEventToState);
    on<GetNews>(_mapGetNewsEventToState);
  }

  void _mapGetSubscribedSourcesEventToState(
      GetSubscribedSources event, Emitter<SubscribedSourcesState> emit) {
    emit(state.copyWith(status: SubscribedSourcesStatus.loading));

    try {
      emit(state.copyWith(
          status: SubscribedSourcesStatus.success,
          subscribedSources:
              subscribedSourcesRepository.getSubscribedSources()));
    } catch (e) {
      emit(state.copyWith(status: SubscribedSourcesStatus.error));
    }
  }

  void _mapSubscribeSourceEventToState(
      SubscribeSource event, Emitter<SubscribedSourcesState> emit) {
    subscribedSourcesRepository.subscribeSource(event.source);
    add(GetSubscribedSources());
    add(FetchNews());
  }

  void _mapUnsubscribeSourceEventToState(
      UnsubscribeSource event, Emitter<SubscribedSourcesState> emit) {
    subscribedSourcesRepository.unsubscribeSource(event.source);
    add(GetSubscribedSources());
    add(FetchNews());
  }

  void _mapToggleSubscriptionSourceEventToState(
      ToggleSubscriptionSource event, Emitter<SubscribedSourcesState> emit) {
    if (state.subscribedSources.contains(event.source)) {
      add(UnsubscribeSource(event.source));
    } else {
      add(SubscribeSource(event.source));
    }

    add(GetSubscribedSources());
  }

  void _mapGetNewsEventToState(
      GetNews event, Emitter<SubscribedSourcesState> emit) {
    emit(state.copyWith(status: SubscribedSourcesStatus.loading));

    try {
      emit(state.copyWith(
          status: SubscribedSourcesStatus.success,
          articles: subscribedSourcesRepository.getArticles()));
    } catch (e) {
      emit(state.copyWith(status: SubscribedSourcesStatus.error));
    }
  }

  void _mapFetchNewsEventToState(
      FetchNews event, Emitter<SubscribedSourcesState> emit) async {
    emit(state.copyWith(status: SubscribedSourcesStatus.loading));

    try {
      await subscribedSourcesRepository.fetchArticles();
      emit(state.copyWith(status: SubscribedSourcesStatus.success));
      add(GetNews());
    } catch (e) {
      emit(state.copyWith(status: SubscribedSourcesStatus.error));
    }
  }
}
