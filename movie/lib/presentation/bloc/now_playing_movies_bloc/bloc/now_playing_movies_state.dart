part of 'now_playing_movies_bloc.dart';

@immutable
sealed class NowPlayingMoviesState extends Equatable {
  const NowPlayingMoviesState();

  @override
  List<Object> get props => [];
}

final class NowPlayingMoviesEmpty extends NowPlayingMoviesState {}

final class NowPlayingMoviesLoading extends NowPlayingMoviesState {}

final class NowPlayingMoviesHasData extends NowPlayingMoviesState {
  final List<Movie> nowPlayingMovies;

  const NowPlayingMoviesHasData(this.nowPlayingMovies);

  @override
  List<Object> get props => [nowPlayingMovies];
}

final class NowPlayingMoviesError extends NowPlayingMoviesState {
  final String message;

  const NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
