import 'package:movies_app/models/AddToFavouriteDataModel.dart';
import 'package:movies_app/models/AddToFavouriteResponseModel.dart';
import 'package:movies_app/models/IsFavouriteModel.dart';
import 'package:movies_app/models/RemoveMovieFromFavourite.dart';

import '../../../models/GetAllFavouriteModel.dart';

abstract class FavouriteRemoteDataSource {
  Future<AddToFavouriteModel?> addToFavourite(
      {required AddToFavouriteDataModel addFavouriteData});

  Future<GetAllFavouriteModel?> getAllFavourite();

  Future<IsFavouriteModel?> isFavourite(String movieId);

  Future<RemoveMovieFromFavourite?> removeFromFavourite(String movieId);
}
