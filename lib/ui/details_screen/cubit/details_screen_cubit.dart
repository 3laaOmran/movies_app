import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/repository/movie_suggestion/repo/movie_suggestion_repository.dart';
import 'package:movies_app/ui/details_screen/cubit/details_screen_states.dart';

import '../../../models/AddToFavouriteDataModel.dart';
import '../../../models/movie_details_model.dart';
import '../../../models/movie_suggestion_model.dart';
import '../../../repository/favourite/repo/favourite_repo.dart';
import '../../../repository/movie_details/repo/movie_details_repo.dart';
@injectable
class DetailsScreenCubit extends Cubit<DetailsScreenStates> {
  final MovieDetailsRepo movieDetailsRepo;
  final MovieSuggestionRepository movieSuggestionRepository;
  FavouriteRepo favouriteRepo;

  DetailsScreenCubit({
    required this.favouriteRepo,
    required this.movieDetailsRepo,
    required this.movieSuggestionRepository,
  }) : super(DetailsScreenLoadingState());

  // bool isFavourite=false;
  static DetailsScreenCubit get(context) => BlocProvider.of(context);

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

  void addMovieToFavourite(
      {required AddToFavouriteDataModel addFavouriteData}) async {
    final List<ConnectivityResult> connectivityList =
        await Connectivity().checkConnectivity();

    if (connectivityList.contains(ConnectivityResult.wifi) ||
        connectivityList.contains(ConnectivityResult.mobile)) {
      try {
        var response = await favouriteRepo.addToFavourite(
            addFavouriteData: addFavouriteData);
        if (response?.statusCode == null) {
          // print("add to favourite success");
          emit(AddToFavouriteSuccessState(message: response!.message!));
        } else {
          print(response!.message!);
          emit(AddToFavouriteErrorState(message: response.message!));
        }
      } catch (e) {
        print(e.toString());
        emit(AddToFavouriteErrorState(message: e.toString()));
      }
    } else {
      print("No Internet Connection");
      emit(AddToFavouriteErrorState(message: "No Internet Connection"));
    }
  }

  void checkIsFavourite(String movieId) async {
    final List<ConnectivityResult> connectivityList =
        await Connectivity().checkConnectivity();

    if (connectivityList.contains(ConnectivityResult.wifi) ||
        connectivityList.contains(ConnectivityResult.mobile)) {
      try {
        var response = await favouriteRepo.isFavourite(movieId);
        if (response?.data != null) {
          emit(IsFavouriteSuccessState(isFavouriteModel: response!));
        } else {
          emit(IsFavouriteErrorState(message: response!.message!));
        }
      } catch (e) {
        emit(IsFavouriteErrorState(message: e.toString()));
      }
    } else {
      emit(IsFavouriteErrorState(message: "No Internet Connection"));
    }
  }

  void removeFromFavourite(String movieId) async {
    final List<ConnectivityResult> connectivityList =
        await Connectivity().checkConnectivity();

    if (connectivityList.contains(ConnectivityResult.wifi) ||
        connectivityList.contains(ConnectivityResult.mobile)) {
      try {
        var response = await favouriteRepo.removeFromFavourite(movieId);
        if (response?.statusCode == null) {
          // isFavourite=false;
          print("movie deleted");
          emit(DeletedSuccessState());
        } else {
          print(response!.message);
          emit(DeletedErrorState(message: response!.message!));
        }
      } catch (e) {
        print(e);
        emit(DeletedErrorState(message: e.toString()));
      }
    } else {
      print("No Internet Connection");
      emit(DeletedErrorState(message: "No Internet Connection"));
    }
  }
}
