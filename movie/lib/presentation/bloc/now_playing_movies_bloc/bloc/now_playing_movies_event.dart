part of 'now_playing_movies_bloc.dart';

@immutable
sealed class NowPlayingMoviesEvent {}

class OnFetchNowPlayingMovies extends NowPlayingMoviesEvent {}
