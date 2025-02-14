import 'package:movies_app/models/update_or_delete_profile_model.dart';
import 'package:movies_app/models/user_model.dart';

abstract class UserRepository {
  Future<UserModel?> getUserData();

  Future<UpdateOrDeleteProfileModel?> updateUserData({
    required String name,
    required String phone,
    required int avatarId,
  });

  Future<void> deleteAccount();
}
