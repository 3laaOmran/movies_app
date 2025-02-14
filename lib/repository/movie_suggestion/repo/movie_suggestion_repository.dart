import 'package:movies_app/models/movie_suggestion_model.dart';

abstract class MovieSuggestionRepository {
  Future<MovieSuggestionModel> getMovieSuggestion(String movieId);
}
