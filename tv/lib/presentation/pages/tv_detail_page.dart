import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tv/presentation/bloc/detail_tv_bloc/bloc/tv_detail_bloc.dart';
import 'package:tv/presentation/bloc/recommendations_tv_bloc/bloc/recommendations_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist_tv_bloc/bloc/watchlist_tv_bloc.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail_tv';

  final int id;

  const TvDetailPage({super.key, required this.id});

  @override
  _TvDetailPageState createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(OnFetchTvDetail(widget.id));
      context.read<WatchlistTvBloc>().add(OnGetWatchlistStatus(widget.id));
      context
          .read<TvRecommendationsBloc>()
          .add(OnFetchTvRecommendations(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: const Key('tv_detail_page'),
        body: BlocBuilder<TvDetailBloc, TvDetailState>(
          builder: (context, state) {
            if (state is TvDetailInitial) {
              return Container();
            } else if (state is TvDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvDetailHasData) {
              return DetailTvContent(tv: state.tvDetail);
            } else if (state is TvDetailError) {
              return Center(
                  key: const Key('error_message'), child: Text(state.message));
            } else {
              return const Center(
                child: Text("Galad :("),
              );
            }
          },
        ));
  }
}

class DetailTvContent extends StatelessWidget {
  final TvDetail tv;

  const DetailTvContent({
    super.key,
    required this.tv,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
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
                              tv.name,
                              style: kHeading5,
                            ),
                            BlocConsumer<WatchlistTvBloc, WatchlistTvState>(
                              listener: (context, state) {
                                if (state is WatchlistTvAddRemoveDataSuccess) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(state.message),
                                    duration: const Duration(milliseconds: 200),
                                  ));
                                  context
                                      .read<WatchlistTvBloc>()
                                      .add(OnGetWatchlistStatus(tv.id));
                                } else if (state
                                    is WatchlistTvAddRemoveDataFailed) {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(state.message),
                                        );
                                      });
                                }
                              },
                              builder: (context, state) {
                                return ElevatedButton(
                                  key: const Key('elevated_button'),
                                  onPressed: state is WatchlistTvDataIsAdded
                                      ? () async {
                                          if (state.status) {
                                            context
                                                .read<WatchlistTvBloc>()
                                                .add(OnRemoveWatchlist(tv));
                                          } else {
                                            context
                                                .read<WatchlistTvBloc>()
                                                .add(OnSaveWatchlist(tv));
                                          }
                                        }
                                      : null,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      state is WatchlistTvDataIsAdded
                                          ? state.status
                                              ? const Icon(
                                                  key: Key("icon_check"),
                                                  Icons.check)
                                              : const Icon(Icons.add)
                                          : const Padding(
                                              padding:
                                                  EdgeInsets.only(right: 3.0),
                                              child: SizedBox(
                                                height: 20.0,
                                                width: 20.0,
                                                child:
                                                    CircularProgressIndicator(
                                                  key: Key(
                                                      'circular_progress_button'),
                                                  color: kRichBlack,
                                                  strokeWidth: 2.0,
                                                ),
                                              ),
                                            ),
                                      const Text('Watchlist'),
                                    ],
                                  ),
                                );
                              },
                            ),
                            Text(
                              _showGenres(tv.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Number of episodes',
                              style: kHeading6,
                            ),
                            Text(
                              tv.numberOfEpisodes.toString(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Number of seasons',
                              style: kHeading6,
                            ),
                            Text(
                              tv.numberOfSeasons.toString(),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tv.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TvRecommendationsBloc,
                                RecommendationsTvState>(
                              builder: (context, state) {
                                if (state is RecommendationsTvInitial) {
                                  return Container(
                                    key: const Key(
                                        'tv_recommendation_container'),
                                  );
                                } else if (state is RecommendationsTvLoading) {
                                  return const Center(
                                    key:
                                        Key("circular_progress_recommedations"),
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is RecommendationsTvHasData) {
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvRecommendation =
                                            state.recommendationsTvList[index];
                                        return Padding(
                                          key: const Key(
                                              'list_view_content_recommendations'),
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TvDetailPage.ROUTE_NAME,
                                                arguments: tvRecommendation.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${tvRecommendation.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount:
                                          state.recommendationsTvList.length,
                                    ),
                                  );
                                } else if (state is RecommendationsTvError) {
                                  return Center(
                                    key: const Key("error_message"),
                                    child: Text(state.message),
                                  );
                                } else {
                                  return const Center(child: Text('Galad :('));
                                }
                              },
                            ),
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
}
