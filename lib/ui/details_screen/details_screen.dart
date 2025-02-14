import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/details_screen/widgets/movie_details.dart';
import 'package:movies_app/ui/widgets/movie_poster.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

import '../../di/di.dart';
import 'cubit/details_screen_cubit.dart';
import 'cubit/details_screen_states.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = 'DetailsScreen';

  DetailsScreen({super.key});

  final DetailsScreenCubit cubit = getIt<DetailsScreenCubit>();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as int;

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
                      url: state.movieDetailsModel.data!.movie!.url!,
                      imagePath:
                          state.movieDetailsModel.data!.movie!.largeCoverImage!,
                      likeCount:
                          state.movieDetailsModel.data!.movie!.likeCount!,
                      movieName: state.movieDetailsModel.data!.movie!.title!,
                      rating: state.movieDetailsModel.data!.movie!.rating!,
                      runTime: state.movieDetailsModel.data!.movie!.runtime!,
                      year: state.movieDetailsModel.data!.movie!.year!),
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
                        SizedBox(
                          height: height * 0.73,
                          child: GridView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: width * 0.03,
                              mainAxisSpacing: height * 0.025,
                              childAspectRatio: 1 / 1.6,
                            ),
                            itemCount:
                                state.movieSuggestionModel.data!.movies!.length,
                            itemBuilder: (context, index) {
                              return MoviePoster(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    DetailsScreen.routeName,
                                    arguments: state.movieSuggestionModel.data!
                                        .movies![index].id,
                                  );
                                  print(
                                      'Movie Id : ${state.movieSuggestionModel.data!.movies![index].id}');
                                },
                                networkImage: state.movieSuggestionModel.data!
                                        .movies![index].largeCoverImage ??
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
                          ),
                        ),
                        SizedBox(height: height * 0.01),
                        Text('Description', style: AppStyles.bold24White),
                        SizedBox(height: height * 0.02),
                        Text(
                            state.movieDetailsModel.data!.movie!
                                    .descriptionFull ??
                                'No Description.......',
                            style: AppStyles.regular16White),
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
