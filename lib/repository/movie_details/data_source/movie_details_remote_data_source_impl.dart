import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_details_model.dart';

import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';
import 'movie_details_remote_data_source.dart';

@Injectable(as: MovieDetailsRemoteDataSource)
class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  @override
  Future<MovieDetailsModel> getMovieDetails(String movieId) async {
    // final String baseUrl = "https://yts.mx/api/v2/movie_details.json";
    // final Map<String, String> queryParams = {
    //   'movie_id': movieId,
    //   'with_cast': 'true',
    // };
    // final Uri url = Uri.parse(baseUrl).replace(queryParameters: queryParams);

    Uri url2 = Uri.https(
        ApiConstants.baseUrl,
        EndPoints.getMovieDetailsEndPoint,
        {"movie_id": movieId, "with_cast": "true", "with_images": "true"});
    try {
      var response = await http.get(url2);
      return MovieDetailsModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
