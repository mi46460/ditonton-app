import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvRecommendation {
  TvRepository repository;

  GetTvRecommendation(this.repository);

  Future<Either<Failure, List<TV>>> execute(int id) {
    return repository.getTvRecommendation(id);
  }
}
