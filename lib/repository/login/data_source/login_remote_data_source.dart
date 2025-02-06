import '../../../models/login_model.dart';

abstract class LoginRemoteDataSource {
  Future<LoginModel?> login(String name, String password);
}
