import 'package:core/data/models/tv_table.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';

final testTv = TV(
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    originalName: 'Original Name',
    name: 'name');

final testTvList = [testTv];

final testTvDetail = TvDetail(
    adult: false,
    backdropPath: "/yYNa1nqvNK94xZz3eKyfvZdAvPi.jpg",
    id: 112470,
    genres: <Genre>[Genre(id: 10766, name: "Soap")],
    name: "Here it all begins",
    overview: "",
    numberOfEpisodes: 733,
    numberOfSeasons: 1,
    posterPath: "/60cqjI590JKXCAABqCStVmSBGET.jpg",
    popularity: 4381.194,
    originalname: "Ici tout commence",
    voteAverage: 6.619,
    voteCount: 21);

final testTvTable = TvTable(
    id: 1396,
    name: "Breaking Bad",
    posterPath: "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.");

final testTvWatchlist = TV.watchList(
    id: 1396,
    name: "Breaking Bad",
    posterPath: "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
    overview:
        "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.");

final testTvMap = {
  "id": 1396,
  "name": "Breaking Bad",
  "overview":
      "When Walter White, a New Mexico chemistry teacher, is diagnosed with Stage III cancer and given a prognosis of only two years left to live. He becomes filled with a sense of fearlessness and an unrelenting desire to secure his family's financial future at any cost as he enters the dangerous world of drugs and crime.",
  "posterPath": "/ztkUQFLlC19CCMYHW9o1zWhJRNq.jpg",
};
