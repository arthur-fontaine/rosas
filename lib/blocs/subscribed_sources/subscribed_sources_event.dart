part of 'subscribed_sources_bloc.dart';

class SubscribedSourcesEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetSubscribedSources extends SubscribedSourcesEvent {}

class SubscribeSource extends SubscribedSourcesEvent {
  final RosasSource source;

  SubscribeSource(this.source);

  @override
  List<Object?> get props => [source];
}

class UnsubscribeSource extends SubscribedSourcesEvent {
  final RosasSource source;

  UnsubscribeSource(this.source);

  @override
  List<Object?> get props => [source];
}

class ToggleSubscriptionSource extends SubscribedSourcesEvent {
  final RosasSource source;

  ToggleSubscriptionSource(this.source);

  @override
  List<Object?> get props => [source];
}
