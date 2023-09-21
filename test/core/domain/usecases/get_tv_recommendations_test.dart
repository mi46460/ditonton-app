import 'package:core/domain/usecases/get_tv_recommendation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendation getTVRecommendation;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    getTVRecommendation = GetTvRecommendation(mockTVRepository);
  });

  final tId = 1;

  test('should return list of tv', () async {
    //arrange
    when(mockTVRepository.getTvRecommendation(tId))
        .thenAnswer((_) async => Right(testTvList));

    //act
    final result = await getTVRecommendation.execute(tId);
    //assert
    expect(result, Right(testTvList));
  });
}
