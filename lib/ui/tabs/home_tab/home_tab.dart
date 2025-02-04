import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/ui/tabs/home_tab/cubit/home_tab_cubit.dart';
import 'package:movies_app/ui/tabs/home_tab/cubit/home_tab_state.dart';
import 'package:movies_app/ui/widgets/category_header.dart';
import 'package:movies_app/ui/widgets/movie_poster.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/asset_manager.dart';

import '../../../di/di.dart';
import '../../../repository/movies/repository/movies_repository.dart';
import '../../../utils/app_styles.dart';
import 'genre_movies_screen.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = 'home_tab';

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var cubit = HomeTabCubit(moviesRepository: getIt<MoviesRepository>());

  @override
  void initState() {
    cubit.getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocProvider(
      create: (context) => cubit,
      child: BlocBuilder<HomeTabCubit, HomeTabStates>(
        builder: (context, state) {
          if (state is MoviesLoadingState) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.yellowColor,
                ),
              ),
            );
          } else if (state is MoviesSuccessState) {
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: state.moviesList[cubit.currentIndex].largeCoverImage!,
                          width: double.infinity,
                          height: height * 0.7,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(
                              color: AppColors.yellowColor,
                            ),
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.error,
                            color: Colors.red,
                            size: 38,
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: height * 0.7,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromARGB(230, 0, 0, 0),
                                Color.fromARGB(150, 0, 0, 0),
                                Color.fromARGB(100, 0, 0, 0),
                                Color.fromARGB(230, 12, 13, 12),
                              ],
                              stops: [0.0, 0.3, 0.6, 1.0],
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Image.asset(
                              AssetsManager.availableNow,
                              height: height * 0.11,
                            ),
                            CarouselSlider.builder(
                              options: CarouselOptions(
                                initialPage: cubit.currentIndex,
                                height: height * 0.4,
                                viewportFraction: 0.55,
                                reverse: true,
                                enlargeCenterPage: true,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                onPageChanged: (index, reason) {
                                  cubit.changeCurrentIndex(index);
                                },
                              ),
                              itemCount: state.moviesList.length,
                              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                  MovieItem(
                                    movieImage: state.moviesList[itemIndex].largeCoverImage!,
                                    rating: state.moviesList[itemIndex].rating?.toString() ?? 'N/A',
                                  ),
                            ),
                            Image.asset(
                              AssetsManager.watchNow,
                              height: height * 0.16,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: width * 0.04,
                              ),
                              child: Column(
                                children: [
                                  ...['Drama', 'Thriller', 'Action', 'Crime', 'Comedy', 'Sci-Fi', 'Family', 'Romance', 'Documentary'].map((genre) {
                                    return Column(
                                      children: [
                                        CategoryHeader(
                                          categoryTitle: genre,
                                          onSeeMoreTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => GenreMoviesScreen(genre: genre, allMovies: state.moviesList),
                                              ),
                                            );
                                          },
                                        ),
                                        SizedBox(height: height * 0.02),
                                        buildMovieList(height, width, genre, state.moviesList),
                                      ],
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (state is MoviesErrorState) {
            return Scaffold(
              body: Center(
                child: Text(
                  state.errorMsg,
                  style: AppStyles.bold24White,
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget buildMovieList(double height, double width, String genre, List<Movie> moviesList) {
    var filteredMovies = moviesList.where((movie) => movie.genres?.contains(genre) ?? false).toList();
    var limitedMovies = filteredMovies.take(10).toList();
    return Container(
      height: height * 0.32,
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return SizedBox(width: width * 0.05);
        },
        scrollDirection: Axis.horizontal,
        itemCount: limitedMovies.length,
        itemBuilder: (context, index) {
          var movie = limitedMovies[index];
          return MoviePoster(
            networkImage: movie.largeCoverImage ?? '',
            rating: movie.rating?.toString() ?? 'N/A',
          );
        },
      ),
    );
  }
}

class MovieItem extends StatelessWidget {
  final String movieImage;
  final String rating;

  const MovieItem({super.key, required this.movieImage, required this.rating});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: CachedNetworkImage(
            imageUrl: movieImage,
            width: double.infinity,
            fit: BoxFit.fill,
            placeholder: (context, url) => Center(
                child: CircularProgressIndicator(color: AppColors.yellowColor)),
            errorWidget: (context, url, error) =>
                Icon(Icons.error, color: Colors.red),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: width * 0.03, vertical: height * 0.015),
          padding: EdgeInsets.symmetric(
              horizontal: width * 0.012, vertical: height * 0.002),
          decoration: BoxDecoration(
              color: AppColors.darkGreyColor,
              borderRadius: BorderRadius.circular(8)),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                rating,
                style: AppStyles.regular16White,
              ),
              SizedBox(
                width: width * 0.01,
              ),
              ImageIcon(
                AssetImage(AssetsManager.ratingIcon),
                size: width * 0.04,
                color: AppColors.yellowColor,
              ),
            ],
          ),
        )
      ],
    );
  }
}