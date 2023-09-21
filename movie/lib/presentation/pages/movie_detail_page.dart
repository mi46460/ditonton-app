import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:core/core.dart';

import '../bloc/movie_detail_bloc/detail_movie_bloc.dart';
import '../bloc/movie_recommendations_bloc/bloc/movie_recommendations_bloc.dart';
import '../bloc/watchlist_movie_bloc/bloc/watchlist_movie_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<WatchlistMovieBloc>().add(OnFetchWatchlistStatus(widget.id));
      context.read<MovieDetailBloc>().add(OnMovieDetail(widget.id));
      context
          .read<MovieRecommendationsBloc>()
          .add(OnFetchMovieRecommendations(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state is MovieDetailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is MovieDetailHasData) {
          return SafeArea(
            child: NewDetailContent(state.movieDetail),
          );
        } else if (state is MovieDetailError) {
          return Center(
              key: const Key("error_message"), child: Text(state.message));
        } else if (state is MovieDetailEmpty) {
          return Container();
        } else {
          return const Center(
            child: Text('Error'),
          );
        }
      },
    ));
  }
}

class NewDetailContent extends StatefulWidget {
  final MovieDetail movie;

  const NewDetailContent(this.movie, {super.key});

  @override
  State<NewDetailContent> createState() => _NewDetailContentState();
}

class _NewDetailContentState extends State<NewDetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      key: const Key("Stack Detail Page"),
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.movie.title,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistMovieBloc,
                                WatchlistMovieState>(
                              listener: (context, state) {
                                if (state
                                    is WatchlistMovieAddRemoveDataSuccess) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    key: const Key("Snackbar"),
                                    content: Text(state.message),
                                    duration: const Duration(milliseconds: 500),
                                  ));
                                  context.read<WatchlistMovieBloc>().add(
                                      OnFetchWatchlistStatus(widget.movie.id));
                                } else if (state
                                    is WatchlistMovieAddRemoveDataFailed) {
                                  showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        content: Text(state.message),
                                      );
                                    },
                                  );
                                  context.read<WatchlistMovieBloc>().add(
                                      OnFetchWatchlistStatus(widget.movie.id));
                                }
                              },
                              builder: (context, state) {
                                if (state is WatchlistMovieDataIsAdded) {
                                  final status = (state).status;

                                  return ElevatedButton(
                                    onPressed: () async {
                                      if (!status) {
                                        context.read<WatchlistMovieBloc>().add(
                                            OnAddToWatchlist(widget.movie));
                                      } else {
                                        context.read<WatchlistMovieBloc>().add(
                                            OnRemoveFromWatchlist(
                                                widget.movie));
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state.status == true
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                  );
                                } else {
                                  return const SizedBox(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              },
                            ),
                            Text(
                              _showGenres(widget.movie.genres),
                            ),
                            Text(
                              _showDuration(widget.movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            SizedBox(
                                height: 150,
                                child: BlocBuilder<MovieRecommendationsBloc,
                                    MovieRecommendationsState>(
                                  builder: (context, state) {
                                    if (state is MovieRecommendatiosLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          key: Key(
                                              "circullar_progress_movie_recom"),
                                        ),
                                      );
                                    } else if (state
                                        is MovieRecommendationsHasData) {
                                      final recommendations =
                                          state.movieRecommendations;

                                      return ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final movie = recommendations[index];
                                          return Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.pushReplacementNamed(
                                                  context,
                                                  MovieDetailPage.ROUTE_NAME,
                                                  arguments: movie.id,
                                                );
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                  placeholder: (context, url) =>
                                                      const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        itemCount: recommendations.length,
                                      );
                                    } else if (state
                                        is MovieRecommendationsError) {
                                      return Center(
                                          key: const Key(
                                              "error_message_from_bloc"),
                                          child: Text(state.message));
                                    } else if (state
                                        is MovieRecommendationsEmpty) {
                                      return Container(
                                        key: const Key(
                                            "Container Movie Recommmendations"),
                                      );
                                    } else {
                                      return const Center(
                                          key: Key("erro_messagge"),
                                          child: Text("Error"));
                                    }
                                  },
                                )),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
