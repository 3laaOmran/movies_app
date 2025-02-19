import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/movies/repository/movies_repository.dart';
import 'package:movies_app/ui/home_screen/tabs/browse_tab/cubit/browse_tab_states.dart';

@injectable
class BrowseTabViewModel extends Cubit<BrowseTabStates> {
  final MoviesRepository moviesRepository;

  BrowseTabViewModel({required this.moviesRepository}) : super(BrowseTabLoadingState());

  List<Movie> moviesList = [];
  List<Movie> filteredMovies = [];
  String selectedGenre = '';

  static BrowseTabViewModel get(context) =>
      BlocProvider.of<BrowseTabViewModel>(
          context);

  void getMovies() async {
    try {
      emit(BrowseTabLoadingState());
      var response = await moviesRepository.getMovies();
      if (response == null || response.status == null) {
        emit(BrowseTabErrorState(errorMsg: response?.statusMessage ?? "Unknown error"));
        return;
      }
      if (response.data?.movies == null) {
        emit(BrowseTabErrorState(errorMsg: "No movies available"));
        return;
      }
      moviesList = response.data!.movies!;
      filteredMovies = moviesList;
      emit(BrowseTabSuccessState(moviesList: filteredMovies));
    } catch (e) {
      emit(BrowseTabErrorState(errorMsg: e.toString()));
      debugPrint('Error: ${e.toString()}');
    }
  }

  void changeSelectedGenre(String genre) {
    selectedGenre = genre;
    filterMovies();
    emit(BrowseTabSuccessState(moviesList: filteredMovies));
  }

  void filterMovies() {
    if (selectedGenre.isEmpty) {
      filteredMovies = moviesList;
    } else {
      filteredMovies = moviesList.where((movie) => movie.genres?.contains(selectedGenre) ?? false).toList();
    }
  }
}
