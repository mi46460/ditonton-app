import 'dart:io';

import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/data/models/tv_table.dart';
import 'package:core/data/repositories/tv_repository_implementations.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVRepositoryImpl repository;
  late MockTVRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    repository = TVRepositoryImpl(
        remoteDataSurce: mockRemoteDataSource,
        localDataSource: mockTvLocalDataSource);
  });

  final tTvModel = TVModel(
      backdropPath: "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
      genreIds: const [10766],
      id: 112470,
      name: "Here it all begins",
      originalName: "Ici tout commence",
      overview: "",
      popularity: 5208.508,
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      voteAverage: 6.7,
      voteCount: 17);

  final tTv = TV(
      backdropPath: "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
      genreIds: const [10766],
      id: 112470,
      name: "Here it all begins",
      originalName: "Ici tout commence",
      overview: "",
      popularity: 5208.508,
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      voteAverage: 6.7,
      voteCount: 17);

  final tTvDetailModel = TVDetailModel(
      adult: false,
      backdropPath: "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
      id: 112470,
      genres: const <GenreModel>[GenreModel(id: 10766, name: "Soap")],
      title: "Here it all begins",
      overview: "",
      numberOfEpisodes: 733,
      numberOfSeasons: 1,
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      popularity: 4381.194,
      originalname: "Ici tout commence",
      voteAverage: 6.619,
      voteCount: 21);

  final tTvDetail = TvDetail(
      adult: false,
      backdropPath: "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
      id: 112470,
      genres: <Genre>[Genre(id: 10766, name: "Soap")],
      name: "Here it all begins",
      overview: "",
      numberOfEpisodes: 733,
      numberOfSeasons: 1,
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      popularity: 4381.194,
      originalname: "Ici tout commence",
      voteAverage: 6.619,
      voteCount: 21);

  final tNewTvTable = TvTable(
      id: 112470,
      name: "Here it all begins",
      posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
      overview: "");

  final tTvTable = TvTable(
      id: 1396,
      name: "Breaking Bad",
      posterPath: "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
      overview:
          "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.");

  final tTvModelList = <TVModel>[tTvModel];
  final tTvList = <TV>[tTv];
  const tTid = 1;

  group('get On Air TV', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getOnAirTv();
      // assert
      verify(mockRemoteDataSource.getOnAirTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirTv()).thenThrow(ServerException());
      // act
      final result = await repository.getOnAirTv();
      // assert
      verify(mockRemoteDataSource.getOnAirTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnAirTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnAirTv();
      // assert
      verify(mockRemoteDataSource.getOnAirTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get Top Rated tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockRemoteDataSource.getTopRatedTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockRemoteDataSource.getTopRatedTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTv();
      // assert
      verify(mockRemoteDataSource.getTopRatedTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get Popular tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTv();
      // assert
      verify(mockRemoteDataSource.getPopularTv());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTv();
      // assert
      verify(mockRemoteDataSource.getPopularTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTv())
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTv();
      // assert
      verify(mockRemoteDataSource.getPopularTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get Detail Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailTv(112470))
          .thenAnswer((_) async => tTvDetailModel);
      // act
      final result = await repository.getDetailTv(112470);
      // assert
      verify(mockRemoteDataSource.getDetailTv(112470));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      expect(result, equals(Right(tTvDetail)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailTv(112470))
          .thenThrow(ServerException());
      // act
      final result = await repository.getDetailTv(112470);
      // assert
      verify(mockRemoteDataSource.getDetailTv(112470));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getDetailTv(112470))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getDetailTv(112470);
      // assert
      verify(mockRemoteDataSource.getDetailTv(112470));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get tv recommendation', () {
    const tId = 1;

    test('Should return of list of tv when', () async {
      //arrange
      when(mockRemoteDataSource.getTvRecommendation(tId))
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getTvRecommendation(tId);
      verify(mockRemoteDataSource.getTvRecommendation(tId));
      //assert
      final finalResult = result.getOrElse(() => []);
      expect(finalResult, tTvList);
    });

    test('should return server failure when throwed server exception',
        () async {
      //arrange
      when(mockRemoteDataSource.getTvRecommendation(tId))
          .thenThrow(ServerException());
      //act
      final result = await repository.getTvRecommendation(tId);
      verify(mockRemoteDataSource.getTvRecommendation(tId));
      //assert
      expect(result, Left(ServerFailure('')));
    });

    test('should return socket failure when throwed socked exception',
        () async {
      //arrange
      when(mockRemoteDataSource.getTvRecommendation(tId))
          .thenThrow(const SocketException(""));
      //act
      final result = await repository.getTvRecommendation(tId);
      verify(mockRemoteDataSource.getTvRecommendation(tId));
      //arrange
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('get Searched Tv', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv('Here it Comes All Together'))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTv('Here it Comes All Together');
      // assert
      verify(mockRemoteDataSource.searchTv('Here it Comes All Together'));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final finalResult = result.getOrElse(() => []);
      expect(finalResult, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv('Here it Comes All Together'))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTv('Here it Comes All Together');
      // assert
      verify(mockRemoteDataSource.searchTv('Here it Comes All Together'));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTv('Here it Comes All Together'))
          .thenThrow(const SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTv('Here it Comes All Together');
      // assert
      verify(mockRemoteDataSource.searchTv('Here it Comes All Together'));
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('insert tv to watchlist', () {
    test('should return tvtable when successfully fetch data', () async {
      //arrange
      when(mockTvLocalDataSource.insertWatchlistTv(tNewTvTable))
          .thenAnswer((_) async => 'Added to watchlist');
      //act
      final result = await repository.saveWatchListTv(tTvDetail);
      //assert
      expect(result, const Right('Added to watchlist'));
    });

    test('should return database failure when failed', () async {
      //arrange
      when(mockTvLocalDataSource.insertWatchlistTv(tNewTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      //act
      final result = await repository.saveWatchListTv(tTvDetail);
      //assert
      expect(result, Left(DatabaseFailure(DatabaseException('').toString())));
    });
  });

  group('remove from watchlist', () {
    test('should return Right success when successfully remove data', () async {
      //arrange
      when(mockTvLocalDataSource.removeWatchlistTv(tNewTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      //act
      final result = await repository.removeFromWatchlistTv(tTvDetail);
      //answer
      expect(result, const Right('Removed from watchlist'));
    });

    test('should return database failure when failed remove data', () async {
      //arrange
      when(mockTvLocalDataSource.removeWatchlistTv(tNewTvTable))
          .thenThrow(DatabaseException("Failed to remove watchlist"));
      //act
      final result = await repository.removeFromWatchlistTv(tTvDetail);
      //assert
      expect(result, Left(DatabaseFailure(DatabaseException('').toString())));
    });
  });

  group('get data from watchlist', () {
    test('should return list of tv table', () async {
      //arrange
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [tTvTable]);
      //act
      final result = await repository.getWatchListTv();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testTvWatchlist]);
    });

    test('should return database failure when failed fetch data', () async {
      //arrange
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenThrow(DatabaseException(''));
      //act
      final result = await repository.getWatchListTv();
      //assert
      expect(result, Left(DatabaseFailure(DatabaseException('').toString())));
    });
  });

  group('get status of tv', () {
    test('should return Tv table when data fetched', () async {
      //arrange
      when(mockTvLocalDataSource.getTvById(tTid))
          .thenAnswer((_) async => tTvTable);
      //act
      final result = await repository.isAddedToWatchlist(tTid);
      //assert
      expect(result, true);
    });
  });

  test('should return false when no data find', () async {
    //arrange
    when(mockTvLocalDataSource.getTvById(tTid))
        .thenAnswer((realInvocation) async => null);
    //act
    final result = await repository.isAddedToWatchlist(tTid);
    //assert
    expect(result, false);
  });
}
