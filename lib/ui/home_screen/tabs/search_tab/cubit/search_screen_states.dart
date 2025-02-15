
import '../../../../../models/movie_model.dart';

class SearchStates{}
class SearchInitialState extends SearchStates{}
class SearchLoadingState extends SearchStates{}
class SearchErrorState extends SearchStates{
  String error;
  SearchErrorState({required this.error});
}
class SearchSuccessState extends SearchStates{
  List<Movie>movieList;
  SearchSuccessState({required this.movieList});
}

