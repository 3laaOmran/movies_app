import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return Center(
                  child: Text(
                state.movieDetailsModel.data!.movie!.title!,
                style: TextStyle(color: Colors.green),
              ));
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
