import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_top_rated_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTVRepository mockTvRepository;

  final tTv = <TV>[];

  setUp(() {
    mockTvRepository = MockTVRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  test('should get list of top rated tv from repository', () async {
    //arrange
    when(mockTvRepository.getTopRatedTv()).thenAnswer((_) async => Right(tTv));

    //act
    final result = await usecase.execute();

    //assert
    expect(result, Right(tTv));
  });
}
