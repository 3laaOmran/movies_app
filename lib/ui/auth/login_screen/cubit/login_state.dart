class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class ChangePasswordVisibilityState extends LoginStates{}
class LoginErrorState extends LoginStates{
  String errorMessage;
  LoginErrorState({required this.errorMessage});
}

class LoginSuccessState extends LoginStates {
  String message;
  String token;

  LoginSuccessState({required this.message, required this.token});
}