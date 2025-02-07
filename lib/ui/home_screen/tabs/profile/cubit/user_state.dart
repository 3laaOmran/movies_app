import 'package:movies_app/models/user_model.dart';

abstract class UserStates {}

final class UserInitialState extends UserStates {}

final class GetUserDataLoadingState extends UserStates {}

final class GetUserDataSuccessState extends UserStates {
  final User user;

  GetUserDataSuccessState({required this.user});
}

final class GetUserDataErrorState extends UserStates {
  String errorMsg;

  GetUserDataErrorState({required this.errorMsg});
}
