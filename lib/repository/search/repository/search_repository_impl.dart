import 'package:injectable/injectable.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/repository/search/data_source/search_data_source_impl.dart';
import 'package:movies_app/repository/search/repository/search_repository.dart';

import '../data_source/search_data_source.dart';
@Injectable(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository{
  SearchDataSource searchDataSource;
  SearchRepositoryImpl({required this.searchDataSource});
  @override
  Future<MovieModel> getSearchedMovie(String query) {
    return searchDataSource.getSearchedMovie( query);
  }

}