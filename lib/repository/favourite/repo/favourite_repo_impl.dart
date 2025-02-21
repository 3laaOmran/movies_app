import 'package:injectable/injectable.dart';
import 'package:movies_app/models/AddToFavouriteDataModel.dart';
import 'package:movies_app/models/GetAllFavouriteModel.dart';
import 'package:movies_app/models/IsFavouriteModel.dart';
import 'package:movies_app/models/RemoveMovieFromFavourite.dart';

import '../../../models/AddToFavouriteResponseModel.dart';
import '../data_source/favourite_remote_data_source.dart';
import 'favourite_repo.dart';

@Injectable(as: FavouriteRepo)
class FavouriteRepoImpl extends FavouriteRepo {
  FavouriteRemoteDataSource favouriteRemoteDataSource;

  FavouriteRepoImpl({required this.favouriteRemoteDataSource});

  @override
  @override
  Future<GetAllFavouriteModel?> getAllFavourite() {
    return favouriteRemoteDataSource.getAllFavourite();
  }

  @override
  Future<IsFavouriteModel?> isFavourite(String movieId) {
    return favouriteRemoteDataSource.isFavourite(movieId);
  }

  @override
  Future<AddToFavouriteModel?> addToFavourite(
      {required AddToFavouriteDataModel addFavouriteData}) {
    return favouriteRemoteDataSource.addToFavourite(
        addFavouriteData: addFavouriteData);
  }

  @override
  Future<RemoveMovieFromFavourite?> removeFromFavourite(String movieId) {
    return favouriteRemoteDataSource.removeFromFavourite(movieId);
  }
}
