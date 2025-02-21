// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../repository/favourite/data_source/favourite_remote_data_source.dart'
    as _i1043;
import '../repository/favourite/data_source/favourite_remote_data_source_impl.dart'
    as _i44;
import '../repository/favourite/repo/favourite_repo.dart' as _i187;
import '../repository/favourite/repo/favourite_repo_impl.dart' as _i55;
import '../repository/login/data_source/login_remote_data_source.dart' as _i912;
import '../repository/login/data_source/login_remote_data_source_impl.dart'
    as _i647;
import '../repository/login/repo/login_repo.dart' as _i516;
import '../repository/login/repo/login_repo_impl.dart' as _i206;
import '../repository/movie_details/data_source/movie_details_remote_data_source.dart'
    as _i715;
import '../repository/movie_details/data_source/movie_details_remote_data_source_impl.dart'
    as _i930;
import '../repository/movie_details/repo/movie_details_repo.dart' as _i482;
import '../repository/movie_details/repo/movie_details_repo_impl.dart' as _i343;
import '../repository/movie_suggestion/data_source/movie_suggestion_remote_data_source.dart'
    as _i29;
import '../repository/movie_suggestion/data_source/movie_suggestion_remote_data_source_impl.dart'
    as _i657;
import '../repository/movie_suggestion/repo/movie_suggestion_repository.dart'
    as _i193;
import '../repository/movie_suggestion/repo/movie_suggestion_repository_impl.dart'
    as _i839;
import '../repository/movies/data_source/movies_remote_data_source.dart'
    as _i330;
import '../repository/movies/data_source/movies_remote_data_source_impl.dart'
    as _i845;
import '../repository/movies/repository/movies_repository.dart' as _i49;
import '../repository/movies/repository/movies_repository_impl.dart' as _i59;
import '../repository/register/data_source/register_data_source.dart' as _i263;
import '../repository/register/data_source/register_data_source_impl.dart'
    as _i182;
import '../repository/register/repository/register_repository.dart' as _i401;
import '../repository/register/repository/register_repository_impl.dart'
    as _i351;
import '../repository/reset_pass/repository/reset_pass_repo.dart' as _i211;
import '../repository/reset_pass/repository/reset_pass_repo_impl.dart' as _i274;
import '../repository/reset_pass/sources/reset_pass_data_source.dart' as _i294;
import '../repository/reset_pass/sources/reset_pass_data_source_impl.dart'
    as _i384;
import '../repository/search/data_source/search_data_source.dart' as _i781;
import '../repository/search/data_source/search_data_source_impl.dart' as _i156;
import '../repository/search/repository/search_repository.dart' as _i806;
import '../repository/search/repository/search_repository_impl.dart' as _i35;
import '../repository/user/data_source/user_remote_data_source.dart' as _i728;
import '../repository/user/data_source/user_remote_data_source_impl.dart'
    as _i175;
import '../repository/user/repository/user_repository.dart' as _i123;
import '../repository/user/repository/user_repository_impl.dart' as _i871;
import '../ui/auth/login_screen/cubit/login_cubit.dart' as _i311;
import '../ui/auth/register_screen/cubit/register_cubit.dart' as _i599;
import '../ui/details_screen/cubit/details_screen_cubit.dart' as _i459;
import '../ui/home_screen/tabs/browse_tab/cubit/browse_tab_view_model.dart'
    as _i52;
import '../ui/home_screen/tabs/home_tab/cubit/home_tab_cubit.dart' as _i165;
import '../ui/home_screen/tabs/profile/cubit/user_cubit.dart' as _i232;
import '../ui/home_screen/tabs/profile/reset_password_screen/cubit/reset_pass_cubit.dart'
    as _i154;
import '../ui/home_screen/tabs/search_tab/cubit/search_screen_cubit.dart'
    as _i779;

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
    gh.factory<_i599.RegisterCubit>(() => _i599.RegisterCubit());
    gh.factory<_i728.UserRemoteDataSource>(
        () => _i175.UserRemoteDataSourceImpl());
    gh.factory<_i330.MoviesRemoteDataSource>(
        () => _i845.MoviesRemoteDataSourceImpl());
    gh.factory<_i781.SearchDataSource>(() => _i156.SearchDataSourceImpl());
    gh.factory<_i263.RegisterDataSource>(() => _i182.RegisterDataSourceImpl());
    gh.factory<_i29.MovieSuggestionRemoteDataSource>(
        () => _i657.MovieSuggestionRemoteDataSourceImpl());
    gh.factory<_i401.RegisterRepository>(() => _i351.RegisterRepositoryImpl(
        registerDataSource: gh<_i263.RegisterDataSource>()));
    gh.factory<_i294.ResetPassDataSource>(
        () => _i384.ResetPassDataSourceImpl());
    gh.factory<_i211.ResetPassRepo>(() =>
        _i274.ResetPassRepoImpl(dataSource: gh<_i294.ResetPassDataSource>()));
    gh.factory<_i193.MovieSuggestionRepository>(() =>
        _i839.MovieSuggestionRepositoryImpl(
            movieSuggestionRemoteDataSource:
                gh<_i29.MovieSuggestionRemoteDataSource>()));
    gh.factory<_i715.MovieDetailsRemoteDataSource>(
        () => _i930.MovieDetailsRemoteDataSourceImpl());
    gh.factory<_i912.LoginRemoteDataSource>(
        () => _i647.LoginRemoteDataSourceImpl());
    gh.factory<_i1043.FavouriteRemoteDataSource>(
        () => _i44.FavouriteRemoteDataSourceImpl());
    gh.factory<_i123.UserRepository>(() => _i871.UserRepositoryImpl(
        remoteDataSource: gh<_i728.UserRemoteDataSource>()));
    gh.factory<_i49.MoviesRepository>(() => _i59.MoviesRepositoryImpl(
        remoteDataSource: gh<_i330.MoviesRemoteDataSource>()));
    gh.factory<_i516.LoginRepo>(() => _i206.LoginRepoImpl(
        loginRemoteDataSource: gh<_i912.LoginRemoteDataSource>()));
    gh.factory<_i806.SearchRepository>(() => _i35.SearchRepositoryImpl(
        searchDataSource: gh<_i781.SearchDataSource>()));
    gh.factory<_i52.BrowseTabViewModel>(() =>
        _i52.BrowseTabViewModel(moviesRepository: gh<_i49.MoviesRepository>()));
    gh.factory<_i165.HomeTabCubit>(() =>
        _i165.HomeTabCubit(moviesRepository: gh<_i49.MoviesRepository>()));
    gh.factory<_i154.ResetPassCubit>(
        () => _i154.ResetPassCubit(resetPassRepo: gh<_i211.ResetPassRepo>()));
    gh.factory<_i482.MovieDetailsRepo>(() => _i343.MovieDetailsRepoImpl(
        movieDetailsRemoteDataSource:
            gh<_i715.MovieDetailsRemoteDataSource>()));
    gh.factory<_i187.FavouriteRepo>(() => _i55.FavouriteRepoImpl(
        favouriteRemoteDataSource: gh<_i1043.FavouriteRemoteDataSource>()));
    gh.factory<_i779.SearchScreenCubit>(() => _i779.SearchScreenCubit(
        searchRepository: gh<_i806.SearchRepository>()));
    gh.factory<_i232.UserCubit>(() => _i232.UserCubit(
          userRepository: gh<_i123.UserRepository>(),
          favouriteRepo: gh<_i187.FavouriteRepo>(),
        ));
    gh.factory<_i459.DetailsScreenCubit>(() => _i459.DetailsScreenCubit(
          favouriteRepo: gh<_i187.FavouriteRepo>(),
          movieDetailsRepo: gh<_i482.MovieDetailsRepo>(),
          movieSuggestionRepository: gh<_i193.MovieSuggestionRepository>(),
        ));
    return this;
  }
}
