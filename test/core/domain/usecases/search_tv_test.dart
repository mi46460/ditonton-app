import 'package:core/domain/usecases/search_tv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:core/domain/entities/tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late SearchTv usecase;
  late MockTVRepository mockTVRepository;

  setUp(() {
    mockTVRepository = MockTVRepository();
    usecase = SearchTv(mockTVRepository);
  });

  final tTv = <TV>[];
  const tQuery = 'Spiderman';

  test('should return search tv series data', () async {
    when(mockTVRepository.searchTv(tQuery)).thenAnswer((_) async => Right(tTv));
    final result = await usecase.execute(tQuery);

    expect(result, Right(tTv));
  });
}
