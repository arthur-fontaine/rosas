import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosas/models/models_barrel.dart';
import 'package:rosas/repositories/repositories_barrel.dart';

part 'read_later_event.dart';

part 'read_later_state.dart';

class ReadLaterBloc extends Bloc<ReadLaterEvent, ReadLaterState> {
  ReadLaterRepository readLaterRepository;

  ReadLaterBloc({required this.readLaterRepository})
      : super(const ReadLaterState()) {
    on<GetReadLaterArticles>(_mapGetReadLaterArticlesEventToState);
    on<AddReadLaterArticle>(_mapAddReadLaterArticleEventToState);
    on<RemoveReadLaterArticle>(_mapRemoveReadLaterArticleEventToState);
    on<ToggleReadLaterArticle>(_mapToggleReadLaterArticleEventToState);
  }

  void _mapGetReadLaterArticlesEventToState(
      GetReadLaterArticles event, Emitter<ReadLaterState> emit) {
    emit(state.copyWith(status: ReadLaterStatus.loading));

    try {
      emit(state.copyWith(
          status: ReadLaterStatus.success,
          articles: readLaterRepository.getReadLaterArticles()));
    } catch (e) {
      emit(state.copyWith(status: ReadLaterStatus.error));
    }
  }

  void _mapAddReadLaterArticleEventToState(AddReadLaterArticle event, Emitter<ReadLaterState> emit) {
    readLaterRepository.addReadLaterArticle(event.article);
    add(GetReadLaterArticles());
  }

  void _mapRemoveReadLaterArticleEventToState(RemoveReadLaterArticle event, Emitter<ReadLaterState> emit) {
    readLaterRepository.removeReadLaterArticle(event.article);
    add(GetReadLaterArticles());
  }

  void _mapToggleReadLaterArticleEventToState(ToggleReadLaterArticle event, Emitter<ReadLaterState> emit) {
    readLaterRepository.toggleReadLaterArticle(event.article);
    add(GetReadLaterArticles());
  }
}
