part of 'watchlist_movie_bloc.dart';

@immutable
sealed class WatchlistMovieEvent {}

class OnRemoveFromWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  OnRemoveFromWatchlist(this.movie);
}

class OnAddToWatchlist extends WatchlistMovieEvent {
  final MovieDetail movie;

  OnAddToWatchlist(this.movie);
}

class OnFetchWatchlistStatus extends WatchlistMovieEvent {
  final int id;

  OnFetchWatchlistStatus(this.id);
}

class OnFetchWatchlistMovie extends WatchlistMovieEvent {}
