part of 'search_tv_bloc.dart';

@immutable
sealed class SearchTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class SearchTvInitial extends SearchTvState {}

final class SearchTvLoading extends SearchTvState {}

final class SearchTvEmpty extends SearchTvState {}

final class SearchTvHasData extends SearchTvState {
  final List<TV> searchTvData;

  SearchTvHasData(this.searchTvData);

  @override
  List<Object?> get props => [searchTvData];
}

final class SearchTvError extends SearchTvState {
  final String message;

  SearchTvError(this.message);

  @override
  List<Object?> get props => [message];
}
