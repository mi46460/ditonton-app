import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc/detail_movie_bloc.dart';

import '../../../core/test/dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([GetMovieDetail])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(mockGetMovieDetail);
  });

  const tId = 1;

  test('should have empty state for initial', () {
    expect(movieDetailBloc.state, MovieDetailEmpty());
  });

  blocTest('should channge state to loading and then to has data',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((realInvocation) async => Right(testMovieDetail));

        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnMovieDetail(tId)),
      expect: () => [MovieDetailLoading(), MovieDetailHasData(testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });

  blocTest('should channge state loading and then to error',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure('Server Failure')));

        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(OnMovieDetail(tId)),
      expect: () =>
          [MovieDetailLoading(), const MovieDetailError('Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });
}
