import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/search_tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/presentation/bloc/search_tv_bloc/bloc/search_tv_bloc.dart';

import '../dummy_objects/dummy_data.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late MockSearchTv mockSearchTv;
  late SearchTvBloc searchTvBloc;

  setUp(() {
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(mockSearchTv);
  });

  const tQuery = "Breaking Bad";

  test('should have state TvSearchInitial for first time', () {
    expect(searchTvBloc.state, SearchTvInitial());
  });

  blocTest(
    'should have state loading when fetching data and state has data when successfully fetch data',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((realInvocation) async => Right(testTvList));

      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnSearchTv(tQuery)),
    expect: () => [SearchTvLoading(), SearchTvHasData(testTvList)],
    verify: (bloc) {
      mockSearchTv.execute(tQuery);
    },
  );

  blocTest(
    'should have state loading when fetching data and state empty when no data',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((realInvocation) async => const Right([]));

      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnSearchTv(tQuery)),
    expect: () => [SearchTvLoading(), SearchTvEmpty()],
    verify: (bloc) {
      mockSearchTv.execute(tQuery);
    },
  );

  blocTest(
    'should have state loading when fetching data and state error when failed fetch data',
    build: () {
      when(mockSearchTv.execute(tQuery)).thenAnswer(
          (realInvocation) async => Left(ServerFailure("Server Failure")));

      return searchTvBloc;
    },
    act: (bloc) => bloc.add(OnSearchTv(tQuery)),
    expect: () => [SearchTvLoading(), SearchTvError("Server Failure")],
    verify: (bloc) {
      mockSearchTv.execute(tQuery);
    },
  );
}
