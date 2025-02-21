import '../../../models/AddToFavouriteDataModel.dart';
import '../../../models/AddToFavouriteResponseModel.dart';
import '../../../models/GetAllFavouriteModel.dart';
import '../../../models/IsFavouriteModel.dart';
import '../../../models/RemoveMovieFromFavourite.dart';

abstract class FavouriteRepo {
  Future<AddToFavouriteModel?> addToFavourite(
      {required AddToFavouriteDataModel addFavouriteData});

  Future<GetAllFavouriteModel?> getAllFavourite();

  Future<IsFavouriteModel?> isFavourite(String movieId);

  Future<RemoveMovieFromFavourite?> removeFromFavourite(String movieId);
}
