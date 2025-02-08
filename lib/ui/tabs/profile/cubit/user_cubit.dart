import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/repository/user/repository/user_repository.dart';
import 'package:movies_app/ui/tabs/profile/cubit/user_state.dart';

@injectable
class UserCubit extends Cubit<UserStates> {
  final UserRepository userRepository;
  int selectedAvatarId = 0;

  UserCubit({required this.userRepository}) : super(UserInitialState());

  var nameController = TextEditingController();
  var phoneController = TextEditingController();

  void getUserData() async {
    emit(GetUserDataLoadingState());
    try {
      var response = await userRepository.getUserData();
      if (response!.user == null) {
        emit(GetUserDataErrorState(errorMsg: response.message!));
        return;
      }
      emit(GetUserDataSuccessState(user: response.user!));
      print('User name is ${response.user!.name}');
      print('Avatar id is ${response.user!.avaterId}');
    } catch (e) {
      rethrow;
    }
  }

  void updateAvatar(int avatarId) {
    selectedAvatarId = avatarId;
    // emit(ChangeAvatarStates());
  }

  void updateUserData(
      {required String name,
      required String phone,
      required String avatarId}) async {
    emit(UpdateUserDataLoadingState());
    try {
      var response = await userRepository.updateUserData(
          name: name, phone: phone, avatarId: avatarId);
      if (response!.statusCode != 200) {
        emit(UpdateUserDataErrorState(errorMsg: "Failed to update user data"));
        print('Error ya 7amo');

        return;
      }

      emit(UpdateUserDataSuccessState(updateProfileModel: response));
    } catch (e) {
      emit(UpdateUserDataErrorState(errorMsg: e.toString()));
      print('Error ya alaa w karim');
    }
  }
}
