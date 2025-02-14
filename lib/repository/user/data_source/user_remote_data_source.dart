import '../../../models/update_or_delete_profile_model.dart';
import '../../../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel?> getUserData();

  Future<UpdateOrDeleteProfileModel?> updateUserData({
    required String name,
    required String phone,
    required int avatarId,
  });

  Future<void> deleteAccount();
}
