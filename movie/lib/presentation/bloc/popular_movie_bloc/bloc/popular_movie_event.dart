part of 'popular_movie_bloc.dart';

@immutable
sealed class PopularMoviesEvent {}

class OnFetchPopularMovie extends PopularMoviesEvent {}
