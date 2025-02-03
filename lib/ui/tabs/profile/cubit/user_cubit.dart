import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/repository/user/repository/user_repository.dart';
import 'package:movies_app/ui/tabs/profile/cubit/user_state.dart';

@injectable
class UserCubit extends Cubit<UserStates> {
  UserRepository userRepository;

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
    } catch (e) {
      rethrow;
    }
  }
}
