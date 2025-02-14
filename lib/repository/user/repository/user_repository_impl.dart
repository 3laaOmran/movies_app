import 'package:injectable/injectable.dart';
import 'package:movies_app/models/update_or_delete_profile_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/repository/user/data_source/user_remote_data_source.dart';
import 'package:movies_app/repository/user/repository/user_repository.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserModel?> getUserData() {
    return remoteDataSource.getUserData();
  }

  @override
  Future<UpdateOrDeleteProfileModel?> updateUserData({
    required String name,
    required String phone,
    required int avatarId,
  }) {
    return remoteDataSource.updateUserData(
        name: name, phone: phone, avatarId: avatarId);
  }

  @override
  Future<void> deleteAccount() {
    return remoteDataSource.deleteAccount();
  }


}
