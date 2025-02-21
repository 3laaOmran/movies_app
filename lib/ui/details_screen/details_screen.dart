import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/details_screen/widgets/movie_details.dart';
import 'package:movies_app/ui/widgets/movie_poster.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:readmore/readmore.dart';

import '../../di/di.dart';
import '../home_screen/tabs/browse_tab/cubit/browse_tab_view_model.dart';
import 'cubit/details_screen_cubit.dart';
import 'cubit/details_screen_states.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = 'DetailsScreen';

  DetailsScreen({super.key});

  final DetailsScreenCubit cubit = getIt<DetailsScreenCubit>();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: BlocBuilder<DetailsScreenCubit, DetailsScreenStates>(
        bloc: cubit..getMovieDetailsAndSuggestions(args.toString()),
        builder: (context, state) {
          if (state is DetailsScreenLoadingState) {
            return Center(
              child: CircularProgressIndicator(color: AppColors.yellowColor),
            );
          } else if (state is DetailsAndSuggestionsSuccessState) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  MovieDetails(
                    movieDetails: state.movieDetailsModel.data!.movie!,
                    // movieId: state.movieDetailsModel.data!.movie!.id!.toInt(),
                    //   url: state.movieDetailsModel.data!.movie!.url!,
                    //   imagePath:
                    //   state.movieDetailsModel.data!.movie!.largeCoverImage!,
                    //   likeCount:
                    //   state.movieDetailsModel.data!.movie!.likeCount!,
                    //   movieName: state.movieDetailsModel.data!.movie!.title!,
                    //   rating: state.movieDetailsModel.data!.movie!.rating!,
                    //   runTime: state.movieDetailsModel.data!.movie!.runtime!,
                    //   year: state.movieDetailsModel.data!.movie!.year!
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: height * 0.02),
                        Text('Screen Shots', style: AppStyles.bold24White),
                        SizedBox(height: height * 0.02),
                        ScreenShotImage(
                            imageUrl: state.movieDetailsModel.data!.movie!
                                .largeScreenshotImage1 ??
                                ''),
                        SizedBox(height: height * 0.015),
                        ScreenShotImage(
                            imageUrl: state.movieDetailsModel.data!.movie!
                                .largeScreenshotImage2 ??
                                ''),
                        SizedBox(height: height * 0.015),
                        ScreenShotImage(
                            imageUrl: state.movieDetailsModel.data!.movie!
                                .largeScreenshotImage3 ??
                                ''),
                        SizedBox(height: height * 0.02),
                        Text('Similar', style: AppStyles.bold24White),
                        SizedBox(height: height * 0.02),
                        state.movieSuggestionModel.data!.movies!.isNotEmpty
                            ? GridView.builder(
                          padding: EdgeInsets.zero,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: width * 0.03,
                            mainAxisSpacing: height * 0.025,
                            childAspectRatio: 1 / 1.6,
                          ),
                          itemCount: state
                              .movieSuggestionModel.data!.movies!.length,
                          itemBuilder: (context, index) {
                            return MoviePoster(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  DetailsScreen.routeName,
                                  arguments: state.movieSuggestionModel
                                      .data!.movies![index].id.toString(),
                                );
                                      BrowseTabViewModel.get(context)
                                          .addToHistory(state
                                              .movieSuggestionModel
                                              .data!
                                              .movies![index]);
                                      print(
                                          'Movie Id : ${state.movieSuggestionModel.data!.movies![index].id}');
                              },
                              networkImage: state
                                  .movieSuggestionModel
                                  .data!
                                  .movies![index]
                                  .largeCoverImage ??
                                  state.movieSuggestionModel.data!
                                      .movies![index].mediumCoverImage ??
                                  state.movieSuggestionModel.data!
                                      .movies![index].smallCoverImage ??
                                  "",
                              rating: state.movieSuggestionModel.data!
                                  .movies![index].rating
                                  .toString(),
                              imageWidth: double.infinity,
                              imageHeight: double.infinity,
                              imageFit: BoxFit.cover,
                            );
                          },
                        )
                            : Text(
                          'No Similar Movies Available...',
                          style: AppStyles.regular16White,
                        ),

                        SizedBox(height: height * 0.02),
                        Text('Description', style: AppStyles.bold24White),
                        SizedBox(height: height * 0.02),
                        ReadMoreText(
                          style: AppStyles.regular16White,
                          state.movieDetailsModel.data!.movie!.descriptionFull!
                              .isEmpty
                              ? 'No Description Available...'
                              : state.movieDetailsModel.data!.movie!
                              .descriptionFull ??
                              '',
                          trimMode: TrimMode.Line,
                          trimLines: 5,
                          colorClickableText: AppColors.yellowColor,
                          trimCollapsedText: 'See More',
                          trimExpandedText: ' See Less',
                          moreStyle: AppStyles.regular16Yellow,
                        ),
                        SizedBox(height: height * 0.02),
                        Text('Cast', style: AppStyles.bold24White),
                        state.movieDetailsModel.data!.movie!.cast != null
                            ? ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: state.movieDetailsModel.data!.movie!
                              .cast!.length,
                          itemBuilder: (context, index) {
                            var castMember = state.movieDetailsModel.data!
                                .movie!.cast![index];
                            return Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: height * 0.006),
                              padding: EdgeInsets.all(11),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: AppColors.darkGreyColor,
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(8),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                      castMember.urlSmallImage ?? '',
                                      width: width * 0.15,
                                      height: height * 0.07,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          CircularProgressIndicator(
                                            color: AppColors.yellowColor,
                                          ),
                                      errorWidget:
                                          (context, url, error) => Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 38),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.02),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text('Name: ${castMember.name}',
                                            style:
                                            AppStyles.regular20White),
                                        Text(
                                            'Character: ${castMember.characterName}',
                                            style:
                                            AppStyles.regular20White),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                            : Text(
                          'No Cast Information Available...',
                          style: AppStyles.regular16White,
                        ),
                        SizedBox(height: height * 0.02),
                        Text('Genres', style: AppStyles.bold24White),
                        SizedBox(height: height * 0.02),
                        Wrap(
                          spacing: width * 0.03,
                          runSpacing: height * 0.015,
                          children: List.generate(
                            state.movieDetailsModel.data!.movie!.genres!.length,
                                (index) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.08,
                                    vertical: height * 0.01),
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreyColor,
                                  // Background color
                                  borderRadius: BorderRadius.circular(
                                      12), // Rounded edges
                                ),
                                child: Text(
                                  state.movieDetailsModel.data!.movie!
                                      .genres![index],
                                  style: AppStyles.regular16White, // Text style
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: height * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is DetailsScreenErrorState) {
            return Center(
              child: Text(state.message, style: TextStyle(color: Colors.green)),
            );
          } else {
            return Center(
                child: Text("error", style: TextStyle(color: Colors.green)));
          }
        },
      ),
    );
  }
}

class ScreenShotImage extends StatelessWidget {
  const ScreenShotImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: double.infinity,
        height: height * 0.2,
        fit: BoxFit.cover,
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(color: AppColors.yellowColor),
        ),
        errorWidget: (context, url, error) =>
            Icon(Icons.error, color: Colors.red, size: 38),
      ),
    );
  }
}
