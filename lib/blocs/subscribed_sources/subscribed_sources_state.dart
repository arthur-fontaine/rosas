part of 'subscribed_sources_bloc.dart';

enum SubscribedSourcesStatus { initial, success, error, loading }

extension SubscribedSourcesStatusX on SubscribedSourcesStatus {
  bool get isInitial => this == SubscribedSourcesStatus.initial;

  bool get isSuccess => this == SubscribedSourcesStatus.success;

  bool get isError => this == SubscribedSourcesStatus.error;

  bool get isLoading => this == SubscribedSourcesStatus.loading;
}

class SubscribedSourcesState extends Equatable {
  final SubscribedSourcesStatus status;
  final List<RosasSource> subscribedSources;

  const SubscribedSourcesState(
      {this.status = SubscribedSourcesStatus.initial,
        this.subscribedSources = const []});

  @override
  List<Object?> get props => [status, subscribedSources];

  SubscribedSourcesState copyWith({
    List<RosasSource>? subscribedSources,
    SubscribedSourcesStatus? status,
  }) {
    return SubscribedSourcesState(
        status: status ?? this.status,
        subscribedSources: subscribedSources ?? this.subscribedSources);
  }
}
