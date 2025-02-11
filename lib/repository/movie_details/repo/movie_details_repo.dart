import '../../../models/movie_details_model.dart';

abstract class MovieDetailsRepo {
  Future<MovieDetailsModel> getMovieDetails(String movieId);
}
