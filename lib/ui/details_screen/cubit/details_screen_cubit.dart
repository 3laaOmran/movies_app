import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/repository/movie_suggestion/repo/movie_suggestion_repository.dart';
import 'package:movies_app/ui/details_screen/cubit/details_screen_states.dart';

import '../../../models/movie_details_model.dart';
import '../../../models/movie_suggestion_model.dart';
import '../../../repository/movie_details/repo/movie_details_repo.dart';
@injectable
class DetailsScreenCubit extends Cubit<DetailsScreenStates> {
  final MovieDetailsRepo movieDetailsRepo;
  final MovieSuggestionRepository movieSuggestionRepository;

  DetailsScreenCubit({
    required this.movieDetailsRepo,
    required this.movieSuggestionRepository,
  }) : super(DetailsScreenLoadingState());

  void getMovieDetailsAndSuggestions(String movieId) async {
    final List<ConnectivityResult> connectivityList =
    await Connectivity().checkConnectivity();

    if (connectivityList.contains(ConnectivityResult.wifi) ||
        connectivityList.contains(ConnectivityResult.mobile)) {
      try {
        emit(DetailsScreenLoadingState());

        final MovieDetailsAndSuggestion = await Future.wait([
          movieDetailsRepo.getMovieDetails(movieId),
          movieSuggestionRepository.getMovieSuggestion(movieId),
        ]);

        final movieDetails = MovieDetailsAndSuggestion[0] as MovieDetailsModel;
        final movieSuggestions =
        MovieDetailsAndSuggestion[1] as MovieSuggestionModel;

        if (movieDetails.status == "ok" && movieSuggestions.status == "ok") {
          emit(DetailsAndSuggestionsSuccessState(
              movieDetailsModel: movieDetails,
              movieSuggestionModel: movieSuggestions));
        } else {
          emit(DetailsScreenErrorState(message: "Something went wrong"));
        }
      } catch (e) {
        emit(DetailsScreenErrorState(message: e.toString()));
      }
    } else {
      emit(DetailsScreenErrorState(message: "No Internet Connection"));
    }
  }


}
