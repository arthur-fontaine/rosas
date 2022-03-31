part of 'theme_bloc.dart';

enum ThemeStatus { initial, success, error, loading }

extension ThemeStatusX on ThemeStatus {
  bool get isInitial => this == ThemeStatus.initial;

  bool get isSuccess => this == ThemeStatus.success;

  bool get isError => this == ThemeStatus.error;

  bool get isLoading => this == ThemeStatus.loading;
}

class ThemeState extends Equatable {
  final ThemeStatus status;
  late final ThemeData themeData;

  ThemeState({this.status = ThemeStatus.initial, themeData}) {
    this.themeData = themeData ?? Themes.rosasDefault.theme;
  }

  @override
  List<Object?> get props => [status, themeData];

  ThemeState copyWith({
    ThemeData? themeData,
    ThemeStatus? status,
  }) {
    return ThemeState(
        status: status ?? this.status,
        themeData: themeData ?? this.themeData);
  }
}
