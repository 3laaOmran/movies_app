import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/ui/details_screen/cubit/details_screen_states.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../repository/movie_details/repo/movie_details_repo.dart';

@injectable
class DetailsScreenCubit extends Cubit<DetailsScreenStates> {
  MovieDetailsRepo movieDetailsRepo;

  DetailsScreenCubit({required this.movieDetailsRepo})
      : super(DetailsScreenLoadingState());

  void getMovieDetails(String movieId) async {
    final List<ConnectivityResult> connectivityList =
        await Connectivity().checkConnectivity();
    if (connectivityList.contains(ConnectivityResult.wifi) ||
        connectivityList.contains(ConnectivityResult.mobile)) {
      try {
        var response = await movieDetailsRepo.getMovieDetails(movieId);
        if (response.status == "ok") {
          emit(DetailsScreenLoadedState(movieDetailsModel: response));
          return;
        } else {
          emit(DetailsScreenErrorState(message: "something went wrong"));
        }
      } catch (e) {
        emit(DetailsScreenErrorState(message: e.toString()));
      }
    } else {
      emit(DetailsScreenErrorState(message: "No internet connection"));
    }
  }


}
