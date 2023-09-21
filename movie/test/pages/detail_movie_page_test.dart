import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../dummy_data/dummy_objects.dart';

class MockDetailMovieBloc extends MockBloc<DetailMovieEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMoviesRecommendationsBloc
    extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class MockWatchlistMovieBloc
    extends MockBloc<WatchlistMovieEvent, WatchlistMovieState>
    implements WatchlistMovieBloc {}

void main() {
  late MockDetailMovieBloc mockDetailMovieBloc;
  late MockMoviesRecommendationsBloc mockMoviesRecommendationsBloc;
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;

  setUp(() {
    mockDetailMovieBloc = MockDetailMovieBloc();
    mockMoviesRecommendationsBloc = MockMoviesRecommendationsBloc();
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
  });

  const tId = 1;

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (BuildContext context) => mockDetailMovieBloc,
        ),
        BlocProvider<MovieRecommendationsBloc>(
          create: (BuildContext context) => mockMoviesRecommendationsBloc,
        ),
        BlocProvider<WatchlistMovieBloc>(
          create: (BuildContext context) => mockWatchlistMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Movie Detail Bloc', () {
    testWidgets('Page should display contianer when initial state',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state).thenReturn(MovieDetailEmpty());

      final containerFinder = find.byType(Container);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(containerFinder, findsOneWidget);
    });

    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state).thenReturn(MovieDetailLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display detail page widget when success',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMoviesRecommendationsBloc.state)
          .thenReturn(MovieRecommendationsHasData(testMovieList));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieDataIsAdded(true));

      final widgetFinder = find.byType(MovieDetailPage);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(widgetFinder, findsOneWidget);
    });

    testWidgets('page should display error message when error',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(const MovieDetailError("Error"));
      final keyFinder = find.byKey(const Key("error_message"));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(keyFinder, findsOneWidget);
    });
  });

  group('Movie Recommendations bloc', () {
    testWidgets('should display container when initial state',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieDataIsAdded(true));
      when(() => mockMoviesRecommendationsBloc.state)
          .thenReturn(MovieRecommendationsEmpty());

      final keyFinder =
          find.byKey(const Key("Container Movie Recommmendations"));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(keyFinder, findsOneWidget);
    });

    testWidgets('should loading when state is loading',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieDataIsAdded(true));
      when(() => mockMoviesRecommendationsBloc.state)
          .thenReturn(MovieRecommendatiosLoading());

      final keyFinder = find.byKey(const Key("circullar_progress_movie_recom"));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(keyFinder, findsOneWidget);
    });

    testWidgets('should display listview when has data',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieDataIsAdded(true));
      when(() => mockMoviesRecommendationsBloc.state)
          .thenReturn(MovieRecommendationsHasData(testMovieList));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('should display error message when failed',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieDataIsAdded(true));
      when(() => mockMoviesRecommendationsBloc.state)
          .thenReturn(const MovieRecommendationsError("error"));

      final keyFinder = find.byKey(const Key("error_message_from_bloc"));

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(keyFinder, findsOneWidget);
    });
  });

  group('Movie Watchlist status', () {
    testWidgets('should find checked icon when movie is added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMoviesRecommendationsBloc.state)
          .thenReturn(MovieRecommendationsHasData(testMovieList));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieDataIsAdded(true));

      final iconFinder = find.byIcon(Icons.check);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(iconFinder, findsOneWidget);
    });

    testWidgets('should find add icon when movie is not added to watchlist',
        (WidgetTester tester) async {
      when(() => mockDetailMovieBloc.state)
          .thenReturn(MovieDetailHasData(testMovieDetail));
      when(() => mockMoviesRecommendationsBloc.state)
          .thenReturn(MovieRecommendationsHasData(testMovieList));
      when(() => mockWatchlistMovieBloc.state)
          .thenReturn(const WatchlistMovieDataIsAdded(false));

      final iconFinder = find.byIcon(Icons.add);

      await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(
        id: tId,
      )));

      expect(iconFinder, findsOneWidget);
    });
  });
}
