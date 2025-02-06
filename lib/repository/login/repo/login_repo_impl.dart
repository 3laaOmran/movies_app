import 'package:injectable/injectable.dart';
import 'package:movies_app/models/login_model.dart';
import 'package:movies_app/repository/login/data_source/login_remote_data_source.dart';
import 'package:movies_app/repository/login/repo/login_repo.dart';

@Injectable(as: LoginRepo)
class LoginRepoImpl implements LoginRepo {
  LoginRemoteDataSource loginRemoteDataSource;

  LoginRepoImpl({required this.loginRemoteDataSource});

  @override
  Future<LoginModel?> login(String name, String password) {
    return loginRemoteDataSource.login(name, password);
  }
}
