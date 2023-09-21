import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc/bloc/watchlist_movie_bloc.dart';

import '../../../core/test/dummy_data/dummy_objects.dart';
import 'watchlist_movie_bloc_test.mocks.dart';

@GenerateMocks(
    [SaveWatchlist, RemoveWatchlist, GetWatchListStatus, GetWatchlistMovies])
void main() {
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistMovieBloc = WatchlistMovieBloc(
      saveWatchlist: mockSaveWatchlist,
      getWatchListStatus: mockGetWatchListStatus,
      getWatchlistMovies: mockGetWatchlistMovies,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  test('should return inital state', () {
    expect(watchlistMovieBloc.state, WatchlistMovieInitial());
  });

  blocTest(
      'should change state to loading and success when scucessfully fetch data',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistMovie]));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      expect: () => [
            WatchlistMovieLoading(),
            WatchlistMovieHasData([testWatchlistMovie])
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });

  blocTest('should change state to loading and error when failed fetch data',
      build: () {
        when(mockGetWatchlistMovies.execute()).thenAnswer(
            (realInvocation) async => Left(ServerFailure("Server Exception")));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      expect: () => [
            WatchlistMovieLoading(),
            const WatchlistMovieError("Server Exception")
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });

  blocTest('should return status true when movie is added to watchlist',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((realInvocation) async => true);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistStatus(tId)),
      expect: () => [const WatchlistMovieDataIsAdded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tId));
      });

  blocTest('should return status flase when movie is not added to watchlist',
      build: () {
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((realInvocation) async => false);

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistStatus(tId)),
      expect: () => [const WatchlistMovieDataIsAdded(false)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tId));
      });

  blocTest('should return success when successfully add data to watchlist',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async => const Right("Successfully add data"));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnAddToWatchlist(testMovieDetail)),
      expect: () =>
          [const WatchlistMovieAddRemoveDataSuccess("Successfully add data")],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      });

  blocTest(
      'should return failed when failed add data and get message from database exception',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure("Database Exception")));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnAddToWatchlist(testMovieDetail)),
      expect: () =>
          [const WatchlistMovieAddRemoveDataFailed("Database Exception")],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      });

  blocTest('should return success when successfully remove data from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async => const Right("Successfully remove data"));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnRemoveFromWatchlist(testMovieDetail)),
      expect: () => [
            const WatchlistMovieAddRemoveDataSuccess("Successfully remove data")
          ],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      });

  blocTest('should return failed when failed remove data from watchlist',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure("Database Exception")));

        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnRemoveFromWatchlist(testMovieDetail)),
      expect: () =>
          [const WatchlistMovieAddRemoveDataFailed("Database Exception")],
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      });
}
