import 'package:dartz/dartz.dart';

import '../../utils/failure.dart';
import '../repositories/movie_repository.dart';
import '../entities/movie_detail.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
