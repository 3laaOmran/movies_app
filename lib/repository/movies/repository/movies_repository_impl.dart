import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/movies/data_source/movies_remote_data_source.dart';
import 'package:movies_app/repository/movies/repository/movies_repository.dart';

@Injectable(as: MoviesRepository)
class MoviesRepositoryImpl implements MoviesRepository {
  MoviesRemoteDataSource remoteDataSource;

  MoviesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieModel?> getMovies() {
    return remoteDataSource.getMovies();
  }
}
