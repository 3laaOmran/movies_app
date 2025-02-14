import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/details_screen/widgets/movie_details.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/utils/asset_manager.dart';

import '../../di/di.dart';
import 'cubit/details_screen_cubit.dart';
import 'cubit/details_screen_states.dart';

class DetailsScreen extends StatelessWidget {
  static String routeName = 'DetailsScreen';

  DetailsScreen({super.key});

  DetailsScreenCubit cubit = getIt<DetailsScreenCubit>();

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as int;
    var height=MediaQuery.of(context).size.height;
    var width=MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<DetailsScreenCubit, DetailsScreenStates>(
          bloc: cubit..getMovieDetails(args.toString()),
          builder: (context, state) {
            if (state is DetailsScreenLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else if (state is DetailsScreenLoadedState) {
              return MovieDetails(
                  url: state.movieDetailsModel.data!.movie!.url!,
                  imagePath: state.movieDetailsModel.data!.movie!.largeCoverImage!,
                  likeCount: state.movieDetailsModel.data!.movie!.likeCount!,
                  movieName:  state.movieDetailsModel.data!.movie!.title!,
                  rating:  state.movieDetailsModel.data!.movie!.rating!,
                  runTime:  state.movieDetailsModel.data!.movie!.runtime!,
                  year:  state.movieDetailsModel.data!.movie!.year!);
            } else if (state is DetailsScreenErrorState) {
              return Center(
                child: Text(
                  "${state.message} Marwan",
                  style: TextStyle(color: Colors.green),
                ),
              );
            } else {
              return Center(
                  child: Text(
                "error",
                style: TextStyle(color: Colors.green),
              ));
            }
          },
        ));
  }
}
