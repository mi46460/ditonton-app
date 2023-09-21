import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/search_tv_bloc/bloc/search_tv_bloc.dart';
import 'package:tv/presentation/pages/search_tv_page.dart';
import '../dummy_objects/dummy_data.dart';

class MockSearchTvBloc extends MockBloc<SearchTvEvent, SearchTvState>
    implements SearchTvBloc {}

void main() {
  late MockSearchTvBloc mockSearchTvBloc;

  setUp(() {
    mockSearchTvBloc = MockSearchTvBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchTvBloc>.value(
      value: mockSearchTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display container when initial state', (tester) async {
    //arraange
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvInitial());

    //act
    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));
    final containerFinder = find.byType(Container);

    //assert
    expect(containerFinder, findsOneWidget);
  });

  testWidgets('should display circular progress indicator when loading',
      (tester) async {
    //arraange
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvLoading());

    //act
    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));
    final circularProgressIndicatorFinder =
        find.byType(CircularProgressIndicator);

    //assert
    expect(circularProgressIndicatorFinder, findsOneWidget);
  });

  testWidgets('should display list view when have data', (tester) async {
    //arraange
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvHasData([testTv]));

    //act
    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));
    final listViewFinder = find.byType(ListView);

    //assert
    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('should display text Empty Data when data not found',
      (tester) async {
    //arraange
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvEmpty());

    //act
    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));
    final textFinder = find.text("Empty Data");

    //assert
    expect(textFinder, findsOneWidget);
  });

  testWidgets('should display error message when error', (tester) async {
    //arraange
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvError("Error"));

    //act
    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));
    final textFinder = find.text("Error");
    final keyFinder = find.byKey(const Key("error_message"));

    //assert
    expect(textFinder, findsOneWidget);
    expect(keyFinder, findsOneWidget);
  });

  testWidgets('TextField should same same input query',
      (WidgetTester tester) async {
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvInitial());

    await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    await tester.enterText(find.byType(TextField), 'Hello, Flutter!');
  });

  testWidgets('should find movie card based on given data',
      (widgetTester) async {
    when(() => mockSearchTvBloc.state).thenReturn(SearchTvHasData([testTv]));

    await widgetTester.pumpWidget(makeTestableWidget(const SearchTvPage()));

    expect(find.byKey(const Key("tv_card")), findsNWidgets([testTv].length));
  });
}
