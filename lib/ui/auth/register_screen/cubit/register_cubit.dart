import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/auth/register_screen/cubit/register_state.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  //TODO: -----------------Data-------------------
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var rePasswordController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPasswordObscure = true;
  bool isRePasswordObscure = true;

//TODO: -----------------Logic-------------------

  void register() {
    if (formKey.currentState!.validate()) {}
  }

  void changePasswordVisibility() {
    isPasswordObscure = !isPasswordObscure;
    emit(ChangePasswordVisibilityState());
  }

  void changeRePasswordVisibility() {
    isRePasswordObscure = !isRePasswordObscure;
    emit(ChangePasswordVisibilityState());
  }
}
