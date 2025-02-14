import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_suggestion_model.dart';

import '../data_source/movie_suggestion_remote_data_source.dart';
import 'movie_suggestion_repository.dart';

@Injectable(as: MovieSuggestionRepository)
class MovieSuggestionRepositoryImpl implements MovieSuggestionRepository {
  MovieSuggestionRemoteDataSource movieSuggestionRemoteDataSource;

  MovieSuggestionRepositoryImpl(
      {required this.movieSuggestionRemoteDataSource});

  @override
  Future<MovieSuggestionModel> getMovieSuggestion(String movieId) {
    return movieSuggestionRemoteDataSource.getMovieSuggestion(movieId);
  }
}
