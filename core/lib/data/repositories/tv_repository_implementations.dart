import 'dart:io';

import 'package:dartz/dartz.dart';

import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';
import '../../utils/exception.dart';
import '../../utils/failure.dart';
import '../datasources/tv_local_data_source.dart';
import '../datasources/tv_remote_data_source.dart';
import '../models/tv_table.dart';

class TVRepositoryImpl implements TvRepository {
  final TVRemoteDataSource remoteDataSurce;
  final TvLocalDataSource localDataSource;

  TVRepositoryImpl(
      {required this.remoteDataSurce, required this.localDataSource});

  @override
  Future<Either<Failure, List<TV>>> getOnAirTv() async {
    try {
      final result = await remoteDataSurce.getOnAirTv();

      return (Right(List<TV>.from(result.map((model) => model.toEntity()))));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTopRatedTv() async {
    try {
      final result = await remoteDataSurce.getTopRatedTv();

      return (Right(List<TV>.from(result.map((model) => model.toEntity()))));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getPopularTv() async {
    try {
      final result = await remoteDataSurce.getPopularTv();

      return (Right(List<TV>.from(result.map((model) => model.toEntity()))));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getDetailTv(int id) async {
    try {
      final result = await remoteDataSurce.getDetailTv(id);

      return (Right(result.toEntitiy()));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> searchTv(String query) async {
    try {
      final result = await remoteDataSurce.searchTv(query);

      return (Right(result.map((model) => model.toEntity()).toList()));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getTvRecommendation(int id) async {
    try {
      final result = await remoteDataSurce.getTvRecommendation(id);

      return (Right(result.map((model) => model.toEntity()).toList()));
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<TV>>> getWatchListTv() async {
    try {
      final result = await localDataSource.getWatchlistTv();

      return Right(List<TV>.from(result.map((model) => model.toEntity())));
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchListTv(TvDetail tv) async {
    try {
      final result =
          await localDataSource.insertWatchlistTv(TvTable.fromEntity(tv));

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> removeFromWatchlistTv(TvDetail tv) async {
    try {
      final result =
          await localDataSource.removeWatchlistTv(TvTable.fromEntity(tv));

      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvById(id);

    return result != null;
  }
}
