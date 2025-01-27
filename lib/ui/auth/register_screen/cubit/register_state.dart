abstract class RegisterStates {}

final class RegisterInitialState extends RegisterStates {}

final class ChangePasswordVisibilityState extends RegisterStates {}

final class RegisterLoadingState extends RegisterStates {}

final class RegisterSuccessState extends RegisterStates {}

final class RegisterErrorState extends RegisterStates {
  final String errorMessage;

  RegisterErrorState({required this.errorMessage});
}
