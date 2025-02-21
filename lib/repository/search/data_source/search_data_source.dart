import '../../../models/movie_model.dart';

abstract class SearchDataSource{
  Future<MovieModel>getSearchedMovie(String query);
}