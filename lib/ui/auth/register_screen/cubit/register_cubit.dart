import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/di/di.dart';
import 'package:movies_app/repository/register/repository/register_repository.dart';
import 'package:movies_app/ui/auth/register_screen/cubit/register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterStates> {
  RegisterRepository registerRepository =getIt<RegisterRepository>();
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
   int avaterId=1;

//TODO: -----------------Logic-------------------
//https://route-movie-apis.vercel.app/auth/register
  void register() async{
    if (formKey.currentState!.validate()) {
     try{
       emit(RegisterLoadingState());
       var response= await registerRepository.register(
           nameController.text,
           emailController.text,
           passwordController.text,
           rePasswordController.text,
           phoneNumberController.text,
           avaterId);
        if (response!.statusCode == 201) {
          emit(RegisterSuccessState());
       } else {
          emit(RegisterErrorState(errorMessage: response.message ?? 'Error'));
        }
     } catch (e) {
       emit(RegisterErrorState(errorMessage: e.toString()));
     }
    }
  }

  void changePasswordVisibility() {
    isPasswordObscure = ! isPasswordObscure;
    emit(ChangePasswordVisibilityState());
  }

  void changeRePasswordVisibility() {
    isRePasswordObscure = ! isRePasswordObscure;
    emit(ChangePasswordVisibilityState());
  }

  void selectAvater(int id){
    avaterId=id;
    emit(changeAvaterId());
  }
}
