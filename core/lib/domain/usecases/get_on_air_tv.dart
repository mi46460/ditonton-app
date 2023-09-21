import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetOnAirTv {
  final TvRepository repository;

  GetOnAirTv(this.repository);

  Future<Either<Failure, List<TV>>> execute() {
    return repository.getOnAirTv();
  }
}
