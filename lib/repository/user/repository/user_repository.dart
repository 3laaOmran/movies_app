import 'package:injectable/injectable.dart';
import 'package:movies_app/models/update_profile_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/repository/user/data_source/user_remote_data_source.dart';

abstract class UserRepository {
  Future<UserModel?> getUserData();

  Future<UpdateProfileModel?> updateUserData({
    required String name,
    required String phone,
    required String avatarId,
  });
}
