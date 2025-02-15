import 'package:movies_app/models/movie_model.dart';

abstract class SearchRepository{
  Future<MovieModel>getSearchedMovie(String query);
}