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
  }

  void updateUserData(
      {required String name,
        required String phone,
        required int avatarId}) async {
    emit(UpdateUserDataLoadingState());
    try {
      var response = await userRepository.updateUserData(
          name: name, phone: phone, avatarId: avatarId);
      if (response!.message!.isNotEmpty) {
        emit(UpdateUserDataSuccessState(updateProfileModel: response));
      }else{
        emit(UpdateUserDataErrorState(errorMsg: "Failed to update user data"));
        print('Error y');
      }

    } catch (e) {
      emit(UpdateUserDataErrorState(errorMsg: e.toString()));
      print('Error y');
    }
  }


  void deleteAccount() async {
    emit(DeleteAccountLoadingState());
    try {
      await userRepository.deleteAccount();
      emit(DeleteAccountSuccessState());
    } catch (e) {
      emit(DeleteAccountErrorState(errorMsg: e.toString()));
    }
  }
}
