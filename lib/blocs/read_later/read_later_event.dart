part of 'read_later_bloc.dart';

class ReadLaterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetReadLaterArticles extends ReadLaterEvent {}

class AddReadLaterArticle extends ReadLaterEvent {
  final RosasArticle article;

  AddReadLaterArticle(this.article);

  @override
  List<Object?> get props => [article];
}

class RemoveReadLaterArticle extends ReadLaterEvent {
  final RosasArticle article;

  RemoveReadLaterArticle(this.article);

  @override
  List<Object?> get props => [article];
}

class ToggleReadLaterArticle extends ReadLaterEvent {
  final RosasArticle article;

  ToggleReadLaterArticle(this.article);

  @override
  List<Object?> get props => [article];
}
