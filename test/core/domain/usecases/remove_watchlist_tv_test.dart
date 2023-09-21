import 'package:core/domain/usecases/remove_watchlist_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockTVRepository mockTVRepository;
  late RemoveWatchlistTv usecase;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = RemoveWatchlistTv(mockTVRepository);
  });

  test('should return success when completed delete from repository', () async {
    //arrange
    when(mockTVRepository.removeFromWatchlistTv(testTvDetail))
        .thenAnswer((_) async => const Right("Removed from watchlist"));
    //act
    final result = await usecase.execute(testTvDetail);
    //assert
    verify(mockTVRepository.removeFromWatchlistTv(testTvDetail));
    expect(result, const Right("Removed from watchlist"));
  });
}
