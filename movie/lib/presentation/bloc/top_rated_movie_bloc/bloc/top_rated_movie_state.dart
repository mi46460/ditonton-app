part of 'top_rated_movie_bloc.dart';

@immutable
sealed class TopRatedMoviesState extends Equatable {
  const TopRatedMoviesState();

  @override
  List<Object?> get props => [];
}

final class TopRatedMoviesEmpty extends TopRatedMoviesState {}

final class TopRatedMoviesLoading extends TopRatedMoviesState {}

final class TopRatedMoviesError extends TopRatedMoviesState {
  final String message;

  const TopRatedMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}

final class TopRatedMoviesHasData extends TopRatedMoviesState {
  final List<Movie> topRatedMovies;

  const TopRatedMoviesHasData(this.topRatedMovies);

  @override
  List<Object?> get props => [topRatedMovies];
}
