import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_recommendations_bloc/bloc/movie_recommendations_bloc.dart';

import 'movie_recommendataion_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieRecommendationsBloc movieRecommendationsBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  const tId = 1;

  test('should empty state for initial', () {
    expect(movieRecommendationsBloc.state, MovieRecommendationsEmpty());
  });

  blocTest('should change state to loading and then change state to has data',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((realInvocation) async => Right(tMovies));

        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieRecommendations(tId)),
      expect: () =>
          [MovieRecommendatiosLoading(), MovieRecommendationsHasData(tMovies)],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest('should change state to loading and then change state to error',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (realInvocation) async => Left(ServerFailure("Server Failure")));

        return movieRecommendationsBloc;
      },
      act: (bloc) => bloc.add(OnFetchMovieRecommendations(tId)),
      expect: () => [
            MovieRecommendatiosLoading(),
            const MovieRecommendationsError('Server Failure')
          ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });
}
