import 'package:movies_app/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getUserData();
}
