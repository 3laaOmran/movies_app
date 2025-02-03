import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/movies/repository/movies_repository.dart';

import 'home_tab_state.dart';

@injectable
class HomeTabCubit extends Cubit<HomeTabStates> {
  final MoviesRepository moviesRepository;

  HomeTabCubit({required this.moviesRepository}) : super(HomeTabInitialState());

  List<Movie> moviesList = [];
  int currentIndex = 0;

  void getMovies() async {
    try {
      emit(MoviesLoadingState());

      var response = await moviesRepository.getMovies();
      if (response == null || response.status == null) {
        emit(MoviesErrorState(
            errorMsg: response?.statusMessage ?? "Unknown error"));
        return;
      }

      if (response.data?.movies == null) {
        emit(MoviesErrorState(errorMsg: "No movies available"));
        return;
      }

      moviesList = response.data!.movies!;
      emit(MoviesSuccessState(moviesList: moviesList));
    } catch (e) {
      emit(MoviesErrorState(errorMsg: e.toString()));
      debugPrint('Error: ${e.toString()}');
    }
  }

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(MoviesSuccessState(moviesList: moviesList));
  }
}
