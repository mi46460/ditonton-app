import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_watchlist_tv.dart';
import 'package:core/domain/usecases/get_watchlist_tv_status.dart';
import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:core/domain/usecases/save_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc/bloc/watchlist_tv_bloc.dart';

import '../dummy_objects/dummy_data.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks(
    [SaveWatchListTv, RemoveWatchlistTv, GetWatchListTvStatus, GetWatchListTv])
void main() {
  late MockSaveWatchListTv mockSaveWatchListTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late MockGetWatchListTv mockGetWatchListTv;
  late MockGetWatchListTvStatus mockGetWatchListTvStatus;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockSaveWatchListTv = MockSaveWatchListTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    mockGetWatchListTv = MockGetWatchListTv();
    mockGetWatchListTvStatus = MockGetWatchListTvStatus();
    watchlistTvBloc = WatchlistTvBloc(
        getWatchListStatus: mockGetWatchListTvStatus,
        getWatchListTv: mockGetWatchListTv,
        removeWatchlistTv: mockRemoveWatchlistTv,
        saveWatchListTv: mockSaveWatchListTv);
  });

  const tId = 1;

  test('should have initial status', () {
    expect(watchlistTvBloc.state, WatchlistTvInitial());
  });

  group('get watchlist data', () {
    blocTest(
      'should change state to loading and state to has data when there are watchlist data',
      build: () {
        when(mockGetWatchListTv.execute())
            .thenAnswer((_) async => Right([testTvWatchlist]));

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistData()),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData([testTvWatchlist])
      ],
      verify: (bloc) {
        mockGetWatchListTv.execute();
      },
    );

    blocTest(
      'should change state to loading and state to empty data when there are no watchlist data',
      build: () {
        when(mockGetWatchListTv.execute())
            .thenAnswer((_) async => const Right(<TV>[]));

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistData()),
      expect: () => [WatchlistTvLoading(), WatchlistTvEmpty()],
      verify: (bloc) {
        mockGetWatchListTv.execute();
      },
    );

    blocTest(
      'should change state to loading and state to error when failed fetch data',
      build: () {
        when(mockGetWatchListTv.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('')));

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistData()),
      expect: () => [WatchlistTvLoading(), WatchlistTvError('')],
      verify: (bloc) {
        mockGetWatchListTv.execute();
      },
    );
  });

  group('get watchlist status', () {
    blocTest(
      'should change return true when there is same data in database',
      build: () {
        when(mockGetWatchListTvStatus.execute(tId))
            .thenAnswer((_) async => true);

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistStatus(tId)),
      expect: () => [WatchlistTvLoading(), WatchlistTvDataIsAdded(true)],
      verify: (bloc) {
        mockGetWatchListTvStatus.execute(tId);
      },
    );

    blocTest(
      'should change return false when there is no same data in database',
      build: () {
        when(mockGetWatchListTvStatus.execute(tId))
            .thenAnswer((_) async => false);

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnGetWatchlistStatus(tId)),
      expect: () => [WatchlistTvLoading(), WatchlistTvDataIsAdded(false)],
      verify: (bloc) {
        mockGetWatchListTvStatus.execute(tId);
      },
    );
  });

  group('insert data to watchlist', () {
    blocTest(
      'should change state to loading and return state to success when success insert data',
      build: () {
        when(mockSaveWatchListTv.execute(testTvDetail)).thenAnswer(
            (realInvocation) async => const Right('Added to Watchlist'));

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvAddRemoveDataSuccess('Added to Watchlist')
      ],
      verify: (bloc) {
        mockSaveWatchListTv.execute(testTvDetail);
      },
    );

    blocTest(
      'should change state to loading and return state to failed when failed save data',
      build: () {
        when(mockSaveWatchListTv.execute(testTvDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure('Database Exception')));

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnSaveWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvAddRemoveDataFailed('Database Exception')
      ],
      verify: (bloc) {
        mockSaveWatchListTv.execute(testTvDetail);
      },
    );
  });

  group('remove data from watchlist', () {
    blocTest(
      'should change state to loading and return state to success when success remove data',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (realInvocation) async => const Right('Removed from watchlist'));

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvAddRemoveDataSuccess('Removed from watchlist')
      ],
      verify: (bloc) {
        mockRemoveWatchlistTv.execute(testTvDetail);
      },
    );

    blocTest(
      'should change state to loading and return state to failed when failed remove data',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure('Database Exception')));

        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnRemoveWatchlist(testTvDetail)),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvAddRemoveDataFailed('Database Exception')
      ],
      verify: (bloc) {
        mockRemoveWatchlistTv.execute(testTvDetail);
      },
    );
  });
}
