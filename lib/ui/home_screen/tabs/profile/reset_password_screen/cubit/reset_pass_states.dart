class ResetPassStates {}

class ResetPassInitialState extends ResetPassStates {}

class ResetPassLoadingState extends ResetPassStates {}

class ResetErrorState extends ResetPassStates {
  String errMsg;

  ResetErrorState({required this.errMsg});
}

class ResetPassSuccessState extends ResetPassStates {
  String message;

  ResetPassSuccessState({required this.message});
}

class ChangePasswordVisibilityState extends ResetPassStates {}
