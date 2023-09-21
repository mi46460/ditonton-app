import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class RemoveWatchlistTv {
  late TvRepository repository;

  RemoveWatchlistTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.removeFromWatchlistTv(tv);
  }
}
