import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:core/utils/exception.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockDatabaseHelper mockDatabaseHelper;
  late TvLocalDataSourceImpl dataSource;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(mockDatabaseHelper);
  });

  final tId = 1;

  group('Insert data to database', () {
    test('should return true when sucessfully insert data to database',
        () async {
      //arange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.insertWatchlistTv(testTvTable);
      //assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw database exception when faling saving data', () {
      //arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException(''));
      //act
      final result = dataSource.insertWatchlistTv(testTvTable);
      //assert
      expect(() => result, throwsA(isA<DatabaseException>()));
    });
  });

  group('get data from database', () {
    test('should return list tv table when success getting data', () async {
      //assert
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((realInvocation) async => [testTvMap]);
      //act
      final result = await dataSource.getWatchlistTv();
      //assert
      expect(result, [testTvTable]);
    });

    test('should throw database exception when failed fetch data', () {
      when(mockDatabaseHelper.getWatchlistTv())
          .thenThrow(DatabaseException(""));
      //act
      result() => dataSource.getWatchlistTv();
      //assert
      expect(result, throwsA(isA<Exception>()));
    });
  });

  group('remove data from database', () {
    test('should return string success when successfully removed from database',
        () async {
      //arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.removeWatchlistTv(testTvTable);
      //assert
      expect(result, 'Removed from watchlist');
    });

    test('should throw database exception when failed', () {
      //arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException(''));
      //act
      result() => dataSource.removeWatchlistTv(testTvTable);
      //assert
      expect(result, throwsA(isA<DatabaseException>()));
    });
  });

  group('get tv by id', () {
    test('should return ', () async {
      //arrange
      when(mockDatabaseHelper.getTvById(tId))
          .thenAnswer((realInvocation) async => testTvMap);
      //act
      final result = await dataSource.getTvById(tId);
      //result
      expect(result, testTvTable);
    });

    test('should return null when data not found', () async {
      //assert
      when(mockDatabaseHelper.getTvById(tId)).thenAnswer((_) async => null);
      //act
      final result = await dataSource.getTvById(tId);
      //assert
      expect(result, null);
    });
  });
}
