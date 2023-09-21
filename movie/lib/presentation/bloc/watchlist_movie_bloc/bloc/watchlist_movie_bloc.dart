import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  final GetWatchListStatus getWatchListStatus;
  final GetWatchlistMovies getWatchlistMovies;

  WatchlistMovieBloc(
      {required this.saveWatchlist,
      required this.getWatchListStatus,
      required this.getWatchlistMovies,
      required this.removeWatchlist})
      : super(WatchlistMovieInitial()) {
    on<OnAddToWatchlist>(
      (event, emit) async {
        final movie = event.movie;

        final result = await saveWatchlist.execute(movie);

        result.fold((failure) {
          emit(WatchlistMovieAddRemoveDataFailed(failure.message));
        }, (sucess) {
          emit(WatchlistMovieAddRemoveDataSuccess(sucess));
        });
      },
    );

    on<OnRemoveFromWatchlist>((event, emit) async {
      final movie = event.movie;

      final result = await removeWatchlist.execute(movie);

      result.fold((failure) {
        emit(WatchlistMovieAddRemoveDataFailed(failure.message));
      }, (sucess) {
        emit(WatchlistMovieAddRemoveDataSuccess(sucess));
      });
    });

    on<OnFetchWatchlistStatus>((event, emit) async {
      final id = event.id;

      final result = await getWatchListStatus.execute(id);

      emit(WatchlistMovieDataIsAdded(result));
    });

    on<OnFetchWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());

      final result = await getWatchlistMovies.execute();

      result.fold((failure) => [emit(WatchlistMovieError(failure.message))],
          (data) => [emit(WatchlistMovieHasData(data))]);
    });
  }
}
