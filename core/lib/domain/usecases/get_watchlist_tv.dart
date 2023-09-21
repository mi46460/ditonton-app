import 'package:dartz/dartz.dart';

import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetWatchListTv {
  final TvRepository repository;

  GetWatchListTv(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getWatchListTv();
  }
}
