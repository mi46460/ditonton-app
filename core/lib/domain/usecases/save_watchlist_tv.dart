import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../entities/tv_detail.dart';
import '../repositories/tv_repository.dart';

class SaveWatchListTv {
  final TvRepository repository;

  SaveWatchListTv(this.repository);

  Future<Either<Failure, String>> execute(TvDetail tv) {
    return repository.saveWatchListTv(tv);
  }
}
