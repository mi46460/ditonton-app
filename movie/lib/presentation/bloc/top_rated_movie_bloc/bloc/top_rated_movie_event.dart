part of 'top_rated_movie_bloc.dart';

@immutable
sealed class TopRatedMoviesEvent {}

class OnFetchTopRatedMovies extends TopRatedMoviesEvent {}
