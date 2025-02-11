import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_details_model.dart';
import 'package:movies_app/repository/movie_details/data_source/movie_details_remote_data_source.dart';
import 'package:movies_app/repository/movie_details/repo/movie_details_repo.dart';

@Injectable(as: MovieDetailsRepo)
class MovieDetailsRepoImpl implements MovieDetailsRepo {
  MovieDetailsRemoteDataSource movieDetailsRemoteDataSource;

  MovieDetailsRepoImpl({required this.movieDetailsRemoteDataSource});

  @override
  Future<MovieDetailsModel> getMovieDetails(String movieId) {
    return movieDetailsRemoteDataSource.getMovieDetails(movieId);
  }
}
