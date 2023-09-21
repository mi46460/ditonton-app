part of 'popular_tv_bloc.dart';

@immutable
sealed class PopularTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class PopularTvInitial extends PopularTvState {}

final class PopularTvLoading extends PopularTvState {}

final class PopularTvHasData extends PopularTvState {
  final List<TV> popularTvList;

  PopularTvHasData(this.popularTvList);

  @override
  List<Object?> get props => [popularTvList];
}

final class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  List<Object?> get props => [message];
}
