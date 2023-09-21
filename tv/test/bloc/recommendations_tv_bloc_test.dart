import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_recommendation.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/recommendations_tv_bloc/bloc/recommendations_tv_bloc.dart';

import 'recommendations_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendation])
void main() {
  late MockGetTvRecommendation mockGetTvRecommendation;
  late TvRecommendationsBloc recommendationsTvBloc;

  setUp(() {
    mockGetTvRecommendation = MockGetTvRecommendation();
    recommendationsTvBloc = TvRecommendationsBloc(mockGetTvRecommendation);
  });

  const tId = 1;

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
    expect(recommendationsTvBloc.state, RecommendationsTvInitial());
  });

  blocTest(
    'should have state loading when fetching data and state has data when successfully fetch data',
    build: () {
      when(mockGetTvRecommendation.execute(tId))
          .thenAnswer((realInvocation) async => Right(tTvList));

      return recommendationsTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvRecommendations(tId)),
    expect: () =>
        [RecommendationsTvLoading(), RecommendationsTvHasData(tTvList)],
    verify: (bloc) {
      mockGetTvRecommendation.execute(tId);
    },
  );

  blocTest(
    'should have state loading when fetching data and state error when failed fetch data',
    build: () {
      when(mockGetTvRecommendation.execute(tId)).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Error")));

      return recommendationsTvBloc;
    },
    act: (bloc) => bloc.add(OnFetchTvRecommendations(tId)),
    expect: () =>
        [RecommendationsTvLoading(), RecommendationsTvError("Server Error")],
    verify: (bloc) {
      mockGetTvRecommendation.execute(tId);
    },
  );
}
