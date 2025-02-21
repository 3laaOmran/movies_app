import 'package:movies_app/models/GetAllFavouriteModel.dart';
import 'package:movies_app/models/update_or_delete_profile_model.dart';
import 'package:movies_app/models/user_model.dart';

abstract class UserStates {}

final class UserInitialState extends UserStates {}

final class GetGoogleUserDataLoadingState extends UserStates {}

final class GetUserDataLoadingState extends UserStates {}

final class GetUserDataSuccessState extends UserStates {
  final User user;

  GetUserDataSuccessState({required this.user});
}

final class GetUserDataErrorState extends UserStates {
  final String errorMsg;

  GetUserDataErrorState({required this.errorMsg});
}

final class UpdateUserDataLoadingState extends UserStates {}


final class UpdateUserDataSuccessState extends UserStates {
  UpdateOrDeleteProfileModel updateProfileModel;

  UpdateUserDataSuccessState({required this.updateProfileModel});
}

final class UpdateUserDataErrorState extends UserStates {
  final String errorMsg;

  UpdateUserDataErrorState({required this.errorMsg});
}

final class DeleteAccountLoadingState extends UserStates {}

final class DeleteAccountSuccessState extends UserStates {}

final class DeleteAccountErrorState extends UserStates {
  final String errorMsg;

  DeleteAccountErrorState({required this.errorMsg});
}

final class getFavouriteLoadingState extends UserStates {}

final class getFavouriteSuccessState extends UserStates {
  GetAllFavouriteModel movies;

  getFavouriteSuccessState({required this.movies});
}

final class getFavouriteErrorState extends UserStates {
  final String errorMsg;

  getFavouriteErrorState({required this.errorMsg});
}
