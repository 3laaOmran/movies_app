import '../../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getUserData();
}
