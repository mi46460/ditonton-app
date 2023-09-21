import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/usecases/search_movies.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:movie/presentation/bloc/search_movie_bloc/bloc/search_movie_bloc.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchMovieBloc(mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];
  const tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchInitial());
  });

  blocTest<SearchMovieBloc, SearchMovieState>(
    'change state to loading and then change state to has data when get data',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((realInvocation) async => Right(tMovieList));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchLoading(), SearchHasData(tMovieList)],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'change state to error when failed fetch data',
    build: () {
      when(mockSearchMovies.execute(tQuery)).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Failure")));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchLoading(), const SearchError("Server Failure")],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchMovieBloc, SearchMovieState>(
    'return state empty when thre is no data',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((realInvocation) async => const Right(<Movie>[]));

      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchLoading(), SearchEmpty()],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
