import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/movies/repository/movies_repository.dart';
import 'package:movies_app/ui/home_screen/tabs/browse_tab/cubit/browse_tab_states.dart';

@injectable
class BrowseTabViewModel extends Cubit<BrowseTabStates> {
  final MoviesRepository moviesRepository;
  late Box<Movie> historyBox;

  BrowseTabViewModel({required this.moviesRepository})
      : super(BrowseTabLoadingState());

  List<Movie> moviesList = [];
  List<Movie> filteredMovies = [];
  String selectedGenre = '';

  static BrowseTabViewModel get(context) =>
      BlocProvider.of<BrowseTabViewModel>(
          context);

  List<Movie> historyList = [];

  // void addToHistory(Movie movie) {
  //   historyList.removeWhere((element) => element.id == movie.id);
  //   historyList.insert(0, movie);
  // }
  void initHive() async {
    historyBox = await Hive.openBox<Movie>('historyBox');
    historyList = historyBox.values.toList();
    emit(BrowseTabSuccessState(moviesList: filteredMovies));
  }

  void addToHistory(Movie movie) {
    historyList.removeWhere((element) => element.id == movie.id);
    historyList.insert(0, movie);
    historyBox.put(movie.id, movie);
  }

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
      filterMovies();
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