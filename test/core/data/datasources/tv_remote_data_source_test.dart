import 'dart:convert';

import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/models/tv_detail_model_response.dart';
import 'package:core/data/models/tv_reponse.dart';
import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get on air tv', () {
    final tTvList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_on_the_air.json')))
        .tvList;

    test('should return list of tv model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_on_the_air.json'), 200));
      // act
      final result = await dataSource.getOnAirTv();
      // assert
      expect(result, equals(tTvList));
    });

    test('should return server exception when status code is 404', () {
      //assert
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.getOnAirTv();
      //arrange
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv', () {
    final tTvList = TVResponse.fromJson(
            json.decode(readJson('dummy_data/tv_top_rated.json')))
        .tvList;

    test('should return list of tv model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_top_rated.json'), 200));
      // act
      final result = await dataSource.getTopRatedTv();
      // assert
      expect(result, equals(tTvList));
    });

    test('should return server exception when status code is 404', () {
      //assert
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.getTopRatedTv();
      //arrange
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tv', () {
    final tTvList =
        TVResponse.fromJson(json.decode(readJson('dummy_data/tv_popular.json')))
            .tvList;

    test('should return list of tv model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_popular.json'), 200));
      // act
      final result = await dataSource.getPopularTv();
      // assert
      expect(result, equals(tTvList));
    });

    test('should return server exception when status code is 404', () {
      //assert
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.getPopularTv();
      //arrange
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get detail tv', () {
    final tTvDetail = TVDetailResponse.fromJson(
            json.decode(readJson('dummy_data/tv_detail.json')))
        .tvDetail;
    const tId = 112470;

    test('should return tv detail model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getDetailTv(tId);
      // assert
      expect(result, equals(tTvDetail));
    });

    test('should return server exception when status code is 404', () {
      //assert
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$tId?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.getDetailTv(tId);
      //arrange
      expect(result, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommendations', () {
    final tTvList = TVResponse.fromJson(
            jsonDecode(readJson('dummy_data/tv_recommendation.json')))
        .tvList;

    const tId = 1;
    test('should return list of tv model', () async {
      //assert
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/tv_recommendation.json'), 200));

      //act
      final result = await dataSource.getTvRecommendation(tId);

      //assert
      expect(result, tTvList);
    });

    test('should throw serer exception when status code 404', () async {
      //assert
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/tv/$tId/recommendations?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.getTvRecommendation(tId);
      //assert
      expect(result, throwsA(isA<ServerException>()));
    });
  });
  group('get searched tv', () {
    final tSearchResult = TVResponse.fromJson(
            jsonDecode(readJson('dummy_data/search_here_it_all_begins.json')))
        .tvList;
    const tQuery = "Here It All Begins";

    test('should return list of tv model when the response code is 200 ',
        () async {
      //arrange
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response(
              readJson('dummy_data/search_here_it_all_begins.json'), 200));

      //act
      final result = await dataSource.searchTv(tQuery);

      //assert
      expect(result, tSearchResult);
    });

    test('should return server exception when status code is 404', () {
      //assert
      when(mockHttpClient
              .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$tQuery')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      //act
      final result = dataSource.searchTv(tQuery);
      //arrange
      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
