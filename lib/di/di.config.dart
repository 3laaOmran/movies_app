// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../repository/movies/data_source/movies_remote_data_source.dart'
    as _i330;
import '../repository/movies/data_source/movies_remote_data_source_impl.dart'
    as _i845;
import '../repository/movies/repository/movies_repository.dart' as _i49;
import '../repository/movies/repository/movies_repository_impl.dart' as _i59;
import '../ui/tabs/home_tab/cubit/home_tab_cubit.dart' as _i538;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i330.MoviesRemoteDataSource>(
        () => _i845.MoviesRemoteDataSourceImpl());
    gh.factory<_i49.MoviesRepository>(() => _i59.MoviesRepositoryImpl(
        remoteDataSource: gh<_i330.MoviesRemoteDataSource>()));
    gh.factory<_i538.HomeTabCubit>(() =>
        _i538.HomeTabCubit(moviesRepository: gh<_i49.MoviesRepository>()));
    return this;
  }
}
