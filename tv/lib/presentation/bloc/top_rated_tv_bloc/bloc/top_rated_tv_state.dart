part of 'top_rated_tv_bloc.dart';

@immutable
sealed class TopRatedTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TopRatedTvInitial extends TopRatedTvState {}

final class TopRatedTvLoading extends TopRatedTvState {}

final class TopRatedTvHasData extends TopRatedTvState {
  final List<TV> topRatedTvList;

  TopRatedTvHasData(this.topRatedTvList);

  @override
  List<Object?> get props => [topRatedTvList];
}

final class TopRatedTvError extends TopRatedTvState {
  final String message;

  TopRatedTvError(this.message);

  @override
  List<Object?> get props => [message];
}
