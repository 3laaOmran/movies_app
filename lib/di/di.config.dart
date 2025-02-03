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

import '../repository/user/data_source/user_remote_data_source.dart' as _i728;
import '../repository/user/data_source/user_remote_data_source_impl.dart'
    as _i175;
import '../repository/user/repository/user_repository.dart' as _i123;
import '../repository/user/repository/user_repository_impl.dart' as _i871;
import '../ui/profile/cubit/user_cubit.dart' as _i726;

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
    gh.factory<_i728.UserRemoteDataSource>(
        () => _i175.UserRemoteDataSourceImpl());
    gh.factory<_i123.UserRepository>(() => _i871.UserRepositoryImpl(
        remoteDataSource: gh<_i728.UserRemoteDataSource>()));
    gh.factory<_i726.UserCubit>(
        () => _i726.UserCubit(userRepository: gh<_i123.UserRepository>()));
    return this;
  }
}
