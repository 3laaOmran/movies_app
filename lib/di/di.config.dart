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

import '../repository/login/data_source/login_remote_data_source.dart' as _i912;
import '../repository/login/data_source/login_remote_data_source_impl.dart';
import '../repository/login/repo/login_repo.dart' as _i516;
import '../repository/login/repo/login_repo_impl.dart';
import '../repository/movies/data_source/movies_remote_data_source.dart'
    as _i330;
import '../repository/movies/data_source/movies_remote_data_source_impl.dart'
    as _i845;
import '../repository/movies/repository/movies_repository.dart' as _i49;
import '../repository/movies/repository/movies_repository_impl.dart' as _i59;
import '../repository/user/data_source/user_remote_data_source.dart' as _i728;
import '../repository/user/data_source/user_remote_data_source_impl.dart'
    as _i175;
import '../repository/user/repository/user_repository.dart' as _i123;
import '../repository/user/repository/user_repository_impl.dart' as _i871;
import '../ui/auth/login_screen/cubit/login_cubit.dart' as _i311;
import '../ui/tabs/home_tab/cubit/home_tab_cubit.dart' as _i538;
import '../ui/tabs/profile/cubit/user_cubit.dart' as _i153;

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
    gh.factory<_i311.LoginCubit>(() => _i311.LoginCubit());
    gh.factory<_i728.UserRemoteDataSource>(
        () => _i175.UserRemoteDataSourceImpl());
    gh.factory<_i330.MoviesRemoteDataSource>(
        () => _i845.MoviesRemoteDataSourceImpl());
    gh.factory<_i912.LoginRemoteDataSource>(() => LoginRemoteDataSourceImpl());
    gh.factory<_i123.UserRepository>(() => _i871.UserRepositoryImpl(
        remoteDataSource: gh<_i728.UserRemoteDataSource>()));
    gh.factory<_i49.MoviesRepository>(() => _i59.MoviesRepositoryImpl(
        remoteDataSource: gh<_i330.MoviesRemoteDataSource>()));
    gh.factory<_i516.LoginRepo>(() => LoginRepoImpl(
        loginRemoteDataSource: gh<_i912.LoginRemoteDataSource>()));
    gh.factory<_i153.UserCubit>(
        () => _i153.UserCubit(userRepository: gh<_i123.UserRepository>()));
    gh.factory<_i538.HomeTabCubit>(() =>
        _i538.HomeTabCubit(moviesRepository: gh<_i49.MoviesRepository>()));
    return this;
  }
}
