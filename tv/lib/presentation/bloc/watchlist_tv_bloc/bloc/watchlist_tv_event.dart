part of 'watchlist_tv_bloc.dart';

@immutable
sealed class WatchlistTvEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class OnFetchWatchlistData extends WatchlistTvEvent {}

class OnSaveWatchlist extends WatchlistTvEvent {
  final TvDetail tvDetail;

  OnSaveWatchlist(this.tvDetail);
}

class OnRemoveWatchlist extends WatchlistTvEvent {
  final TvDetail tvDetail;

  OnRemoveWatchlist(this.tvDetail);
}

class OnGetWatchlistStatus extends WatchlistTvEvent {
  final int id;

  OnGetWatchlistStatus(this.id);
}
