import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/repository/favourite/repo/favourite_repo.dart';
import 'package:movies_app/repository/user/repository/user_repository.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/cubit/user_state.dart';

import '../../../../../models/GetAllFavouriteModel.dart';

@injectable
class UserCubit extends Cubit<UserStates> {
  final UserRepository userRepository;
  FavouriteRepo favouriteRepo;
  int selectedAvatarId = 0;

  List<GetAllFavouriteData>? favoriteMovieList = [];

  UserCubit({required this.userRepository, required this.favouriteRepo})
      : super(UserInitialState());

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var googleUserImage;

  static UserCubit get(context) => BlocProvider.of(context);

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

  void getGoogleUserDetails() {
    emit(GetGoogleUserDataLoadingState());
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

  void getFavouriteMovies() async {
    try {
      emit(getFavouriteLoadingState());
      var response = await favouriteRepo.getAllFavourite();
      if (response!.statusCode == null) {
        favoriteMovieList = response.data;
        emit(getFavouriteSuccessState(movies: response));
      } else {
        emit(getFavouriteErrorState(errorMsg: response.message!));
      }
    } catch (e) {
      emit(getFavouriteErrorState(errorMsg: e.toString()));
    }
  }
}
