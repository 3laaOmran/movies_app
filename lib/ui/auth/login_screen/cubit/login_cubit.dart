import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/login_screen/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginStates>{
  LoginCubit():super(LoginInitialState());

var emailController=TextEditingController();
var passwordController=TextEditingController();
var formKey =GlobalKey<FormState>() ;
bool isPasswordObscure = true;

void  login(){
  if(formKey.currentState!.validate());
}

void changePasswordVisibility(){
  isPasswordObscure=!isPasswordObscure;
  emit(ChangePasswordVisibilityState());
}

}