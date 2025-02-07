import 'package:movies_app/models/login_model.dart';

abstract class LoginRepo {
  Future<LoginModel?> login(String name, String password);
}
