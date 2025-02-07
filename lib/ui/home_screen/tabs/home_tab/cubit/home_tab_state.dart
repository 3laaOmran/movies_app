import 'package:movies_app/models/movie_model.dart';

abstract class HomeTabStates {}

class HomeTabInitialState extends HomeTabStates {}

class MoviesLoadingState extends HomeTabStates {}

class MoviesSuccessState extends HomeTabStates {
  List<Movie> moviesList;

  MoviesSuccessState({required this.moviesList});
}

class MoviesErrorState extends HomeTabStates {
  String errorMsg;

  MoviesErrorState({required this.errorMsg});
}
