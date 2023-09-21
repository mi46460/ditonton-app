import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movie/movie.dart';
import 'package:mocktail/mocktail.dart';

import '../dummy_data/dummy_objects.dart';

class MockSearchMoviesBloc extends MockBloc<SearchMovieEvent, SearchMovieState>
    implements SearchMovieBloc {}

void main() {
  late MockSearchMoviesBloc mockSearchMoviesBloc;

  setUp(() {
    mockSearchMoviesBloc = MockSearchMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchMovieBloc>.value(
      value: mockSearchMoviesBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state).thenReturn(SearchLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state)
        .thenReturn(const SearchHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state)
        .thenReturn(const SearchHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text error when failed fetch data',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state)
        .thenReturn(const SearchError('Search Error'));

    final textFinder = find.byKey(const Key("error_message"));

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display search not found when get empty data',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state).thenReturn(SearchEmpty());

    final textFinder = find.text('Search Not Found');

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display empty container when inital search',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state).thenReturn(SearchInitial());

    final textFinder = find.byType(Container);

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('TextField should same same input query',
      (WidgetTester tester) async {
    when(() => mockSearchMoviesBloc.state).thenReturn(SearchInitial());

    await tester.pumpWidget(_makeTestableWidget(const SearchPage()));

    await tester.enterText(find.byType(TextField), 'Hello, Flutter!');
  });

  testWidgets('should find movie card based on given data',
      (widgetTester) async {
    when(() => mockSearchMoviesBloc.state)
        .thenReturn(SearchHasData([testMovie]));

    await widgetTester.pumpWidget(_makeTestableWidget(const SearchPage()));

    expect(
        find.byKey(const Key("movie_card")), findsNWidgets([testMovie].length));
  });
}
