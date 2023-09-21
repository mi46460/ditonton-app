import '../../utils/exception.dart';
import '../models/tv_table.dart';
import 'db/database_helper.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlistTv(TvTable tv);
  Future<List<TvTable>> getWatchlistTv();
  Future<String> removeWatchlistTv(TvTable tv);
  Future<TvTable?> getTvById(int id);
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<String> insertWatchlistTv(TvTable tv) async {
    try {
      await databaseHelper.insertWatchlistTv(tv);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<TvTable>> getWatchlistTv() async {
    try {
      final result = await databaseHelper.getWatchlistTv();

      return List<TvTable>.from(result.map((data) => TvTable.fromMap(data)));
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlistTv(TvTable tv) async {
    try {
      await databaseHelper.removeWatchlistTv(tv);

      return 'Removed from watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvTable?> getTvById(int id) async {
    final result = await databaseHelper.getTvById(id);

    if (result != null) {
      return TvTable.fromMap(result);
    } else {
      return null;
    }
  }
}
