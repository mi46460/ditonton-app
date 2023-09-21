import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../utils/exception.dart';
import '../models/tv_detail_model.dart';
import '../models/tv_detail_model_response.dart';
import '../models/tv_model.dart';
import '../models/tv_reponse.dart';

abstract class TVRemoteDataSource {
  Future<List<TVModel>> getOnAirTv();
  Future<List<TVModel>> getTopRatedTv();
  Future<List<TVModel>> getPopularTv();
  Future<List<TVModel>> getTvRecommendation(int id);
  Future<List<TVModel>> searchTv(String query);
  Future<TVDetailModel> getDetailTv(int id);
}

class TVRemoteDataSourceImpl implements TVRemoteDataSource {
  static const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  TVRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVModel>> getOnAirTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTopRatedTv() async {
    final response = await client.get(Uri.parse(
        'https://api.themoviedb.org/3/tv/top_rated?api_key=2174d146bb9c0eab47529b2e77d6b526'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getPopularTv() async {
    final response =
        await client.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  Future<TVDetailModel> getDetailTv(int id) async {
    final response = await client.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY'));

    if (response.statusCode == 200) {
      return TVDetailResponse.fromJson(json.decode(response.body)).tvDetail;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> searchTv(String query) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(json.decode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVModel>> getTvRecommendation(int id) async {
    final response = await client
        .get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY'));

    if (response.statusCode == 200) {
      return TVResponse.fromJson(jsonDecode(response.body)).tvList;
    } else {
      throw ServerException();
    }
  }
}
