part of 'theme_bloc.dart';

class ThemeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetThemeData extends ThemeEvent {}

class SetThemeData extends ThemeEvent {
  final ThemeData themeData;

  SetThemeData(this.themeData);

  @override
  List<Object?> get props => [themeData];
}
