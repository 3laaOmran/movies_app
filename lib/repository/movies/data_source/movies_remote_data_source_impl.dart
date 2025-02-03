import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/api/api_constants.dart';
import 'package:movies_app/api/end_points.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/movies/data_source/movies_remote_data_source.dart';

@Injectable(as: MoviesRemoteDataSource)
class MoviesRemoteDataSourceImpl implements MoviesRemoteDataSource {
  @override
  Future<MovieModel?> getMovies() async {
    // https://yts.mx/api/v2/list_movies.json
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.moviesEndPoint);

    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}
