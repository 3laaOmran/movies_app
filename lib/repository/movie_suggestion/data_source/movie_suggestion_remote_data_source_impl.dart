import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_suggestion_model.dart';

import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';
import 'movie_suggestion_remote_data_source.dart';

@Injectable(as: MovieSuggestionRemoteDataSource)
class MovieSuggestionRemoteDataSourceImpl
    implements MovieSuggestionRemoteDataSource {
  @override
  Future<MovieSuggestionModel> getMovieSuggestion(String movieId) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.getMovieSuggestion, {
      "movie_id": movieId,
    });
    try {
      var response = await http.get(url);
      return MovieSuggestionModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
