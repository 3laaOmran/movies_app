import '../../../models/update_profile_model.dart';
import '../../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getUserData();

  Future<UpdateProfileModel?> updateUserData({
    required String name,
    required String phone,
    required int avatarId,
  });
}
