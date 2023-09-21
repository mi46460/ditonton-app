import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure, List<TV>>> getOnAirTv();
  Future<Either<Failure, List<TV>>> getTopRatedTv();
  Future<Either<Failure, List<TV>>> getPopularTv();
  Future<Either<Failure, List<TV>>> searchTv(String query);
  Future<Either<Failure, List<TV>>> getTvRecommendation(int id);
  Future<Either<Failure, TvDetail>> getDetailTv(int id);
  Future<Either<Failure, List<TV>>> getWatchListTv();
  Future<Either<Failure, String>> saveWatchListTv(TvDetail tv);
  Future<Either<Failure, String>> removeFromWatchlistTv(TvDetail tv);
  Future<bool> isAddedToWatchlist(int id);
}
