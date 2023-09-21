import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie/movie.dart';

import '../dummy_data/dummy_objects.dart';

class MockNowPlayingMoviesBloc
    extends MockBloc<NowPlayingMoviesEvent, NowPlayingMoviesState>
    implements NowPlayingMoviesBloc {}

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class MockTopRatedMoviesbloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

void main() {
  late MockNowPlayingMoviesBloc mockNowPlayingMoviesBloc;
  late MockTopRatedMoviesbloc mockTopRatedMoviesbloc;
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUp(() {
    mockNowPlayingMoviesBloc = MockNowPlayingMoviesBloc();
    mockPopularMoviesBloc = MockPopularMoviesBloc();
    mockTopRatedMoviesbloc = MockTopRatedMoviesbloc();
  });

  Widget makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NowPlayingMoviesBloc>(
          create: (context) => mockNowPlayingMoviesBloc,
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (context) => mockTopRatedMoviesbloc,
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (context) => mockPopularMoviesBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'should display circular progress indicator when state is loading',
      (widgetTester) async {
    when(() => mockNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesLoading());
    when(() => mockTopRatedMoviesbloc.state)
        .thenReturn(TopRatedMoviesLoading());
    when(() => mockPopularMoviesBloc.state).thenReturn(PopularMoviesLoading());

    await widgetTester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    final widgetFinder = find.byType(CircularProgressIndicator);

    expect(widgetFinder, findsNWidgets(3));
  });

  testWidgets(
      'should display TvList widget and ListView widget when state is has data',
      (widgetTester) async {
    when(() => mockNowPlayingMoviesBloc.state)
        .thenReturn(NowPlayingMoviesHasData(testMovieList));
    when(() => mockTopRatedMoviesbloc.state)
        .thenReturn(TopRatedMoviesHasData(testMovieList));
    when(() => mockPopularMoviesBloc.state)
        .thenReturn(PopularMoviesHasData(testMovieList));

    await widgetTester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

    final widgetFinder = find.byType(MovieList);
    final listViewFinder = find.byType(ListView);

    expect(widgetFinder, findsNWidgets(3));
    expect(listViewFinder, findsNWidgets(3));
  });
}
