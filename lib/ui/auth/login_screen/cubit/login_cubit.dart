import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/ui/auth/login_screen/cubit/login_state.dart';

import '../../../../di/di.dart';
import '../../../../repository/login/repo/login_repo.dart';
import '../../../../utils/helpers/cash_helper.dart';

@injectable
class LoginCubit extends Cubit<LoginStates>{
  LoginRepo loginRepo = getIt<LoginRepo>();
  LoginCubit():super(LoginInitialState());

var emailController=TextEditingController();
var passwordController=TextEditingController();
var formKey =GlobalKey<FormState>() ;
bool isPasswordObscure = true;

  void login() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(LoginLoadingState());
        var response = await loginRepo.login(
            emailController.text, passwordController.text);
        if (response!.statusCode == null) {
          emit(LoginSuccessState(
              message: response.message, token: response.data!));
          CashHelper.saveData(key: "isLoggedIn", value: true);
          CashHelper.saveData(key: "token", value: response.data);
        } else {
          if (response.message is String) {
            emit(LoginErrorState(errorMessage: response.message));
            return;
          }
          emit(LoginErrorState(errorMessage: response.message[0]));
        }
      } catch (e) {
        emit(LoginErrorState(errorMessage: e.toString()));
      }
    }
    ;
  }

void changePasswordVisibility(){
  isPasswordObscure=!isPasswordObscure;
}

}