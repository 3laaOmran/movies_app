import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/AddToFavouriteDataModel.dart';
import 'package:movies_app/models/AddToFavouriteResponseModel.dart';
import 'package:movies_app/models/GetAllFavouriteModel.dart';
import 'package:movies_app/models/IsFavouriteModel.dart';
import 'package:movies_app/models/RemoveMovieFromFavourite.dart';
import 'package:movies_app/utils/helpers/cash_helper.dart';

import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';
import 'favourite_remote_data_source.dart';

@Injectable(as: FavouriteRemoteDataSource)
class FavouriteRemoteDataSourceImpl extends FavouriteRemoteDataSource {
  var token = CashHelper.getData(key: 'token');

  @override
  // Future<AddToFavouriteModel?> addToFavourite(String movieId, String name,
  //     dynamic rating, String imageUrl, String year) async {
  //
  //   Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.addToFavourite);
  //   try {
  //     var response =
  //         await http.post(url, body:
  //         {
  //           "movieId": movieId,
  //           'name': name,
  //           'rating': rating,
  //           'imageURL': imageUrl,
  //           'year': year
  //         },
  //           headers: {
  //             'Authorization': 'Bearer $token'
  //           }
  //         );
  //     return AddToFavouriteModel.fromJson(jsonDecode(response.body));
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  @override
  Future<GetAllFavouriteModel?> getAllFavourite() async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.getAllFavourite);
    try {
      // Todo : edit token before upload
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      return GetAllFavouriteModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<IsFavouriteModel?> isFavourite(String movieId) async {
    Uri url = Uri.https(
        ApiConstants.authBaseUrl, "${EndPoints.isFavourite}/$movieId");
    try {
      // Todo : edit token before upload
      var response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      return IsFavouriteModel.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      throw e;
    }
  }

  @override
  Future<AddToFavouriteModel?> addToFavourite(
      {required AddToFavouriteDataModel addFavouriteData}) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.addToFavourite);
    try {
      var response = await http.post(url,
          body: jsonEncode(
            {
              "movieId": addFavouriteData.movieId,
              'name': addFavouriteData.name,
              'rating': addFavouriteData.rating,
              'imageURL': addFavouriteData.imageURL,
              'year': addFavouriteData.year
            },
          ),
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json"
          });
      return AddToFavouriteModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<RemoveMovieFromFavourite?> removeFromFavourite(String movieId) async {
    Uri url = Uri.https(
        ApiConstants.authBaseUrl, "${EndPoints.removeFromFavourite}/$movieId");
    try {
      var response =
          await http.delete(url, headers: {'Authorization': 'Bearer $token'});
      return RemoveMovieFromFavourite.fromJson(jsonDecode(response.body));
    } on Exception catch (e) {
      throw e;
    }
  }
}
