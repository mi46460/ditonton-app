part of 'watchlist_tv_bloc.dart';

@immutable
sealed class WatchlistTvState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class WatchlistTvInitial extends WatchlistTvState {}

final class WatchlistTvLoading extends WatchlistTvState {}

final class WatchlistTvEmpty extends WatchlistTvState {}

final class WatchlistTvHasData extends WatchlistTvState {
  final List<TV> watchlistTvList;

  WatchlistTvHasData(this.watchlistTvList);

  @override
  List<Object?> get props => [watchlistTvList];
}

final class WatchlistTvError extends WatchlistTvState {
  final String message;

  WatchlistTvError(this.message);

  @override
  List<Object?> get props => [message];
}

final class WatchlistTvDataIsAdded extends WatchlistTvState {
  final bool status;

  WatchlistTvDataIsAdded(this.status);

  @override
  List<Object?> get props => [status];
}

final class WatchlistTvAddRemoveDataSuccess extends WatchlistTvState {
  final String message;

  WatchlistTvAddRemoveDataSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

final class WatchlistTvAddRemoveDataFailed extends WatchlistTvState {
  final String message;

  WatchlistTvAddRemoveDataFailed(this.message);

  @override
  List<Object?> get props => [message];
}
