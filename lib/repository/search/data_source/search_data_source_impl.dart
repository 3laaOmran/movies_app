import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/api/api_constants.dart';
import 'package:movies_app/api/end_points.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/search/data_source/search_data_source.dart';
@Injectable(as: SearchDataSource)
class SearchDataSourceImpl implements SearchDataSource {
  // https://yts.mx/api/v2/list_movies.json

  @override
  Future<MovieModel> getSearchedMovie(String query) async {
    Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.moviesEndPoint, {
      'query_term': query
    });
    try {
      var response = await http.get(url);
      return MovieModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      rethrow;
    }
  }
}