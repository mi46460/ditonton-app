import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/popular_tv_bloc/bloc/popular_tv_bloc.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  final tTv = TV(
      backdropPath: 'backdropPath',
      genreIds: const [1, 2, 3],
      id: 1,
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      voteAverage: 1,
      voteCount: 1,
      originalName: 'Original Name',
      name: 'name');

  final tTvList = <TV>[tTv];

  test('should have initial state', () {
    expect(popularTvBloc.state, PopularTvInitial());
  });

  blocTest(
    'should have state loading when fetching data and state has data when successfully fetch data',
    build: () {
      when(mockGetPopularTv.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));

      return popularTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchPopularTv()),
    expect: () => [PopularTvLoading(), PopularTvHasData(tTvList)],
    verify: (bloc) {
      mockGetPopularTv.execute();
    },
  );

  blocTest(
    'should have state loading when fetching data and state error when failed fetch data',
    build: () {
      when(mockGetPopularTv.execute()).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Error")));

      return popularTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchPopularTv()),
    expect: () => [PopularTvLoading(), PopularTvError("Server Error")],
    verify: (bloc) {
      mockGetPopularTv.execute();
    },
  );
}
