import 'package:movies_app/models/movie_model.dart';

abstract class MoviesRemoteDataSource {
  Future<MovieModel?> getMovies();
}
