import 'package:movies_app/models/movie_model.dart';

abstract class BrowseTabStates {}

class BrowseTabLoadingState extends BrowseTabStates {}

class BrowseTabErrorState extends BrowseTabStates {
  String errorMsg;
  BrowseTabErrorState({required this.errorMsg});
}

class BrowseTabSuccessState extends BrowseTabStates {
  List<Movie> moviesList;
  BrowseTabSuccessState({required this.moviesList});
}
