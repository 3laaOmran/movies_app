import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/repository/reset_pass/repository/reset_pass_repo.dart';
import 'package:movies_app/ui/home_screen/tabs/profile/reset_password_screen/cubit/reset_pass_states.dart';

import '../../../../../../utils/helpers/cash_helper.dart';

@injectable
class ResetPassCubit extends Cubit<ResetPassStates> {
  ResetPassRepo resetPassRepo;

  ResetPassCubit({required this.resetPassRepo})
      : super(ResetPassInitialState());
  var oldPassController = TextEditingController();
  var newPassController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  bool isOldPasswordObscure = true;
  bool isNewPasswordObscure = true;

  void ChangePass() async {
    var token = CashHelper.getData(key: "token");
    if (formKey.currentState!.validate()) {
      try {
        emit(ResetPassLoadingState());
        var response = await resetPassRepo.ChangePassword(
            oldPassController.text, newPassController.text, token);
        if (response!.statusCode == null) {
          emit(ResetPassSuccessState(message: response.message));
        } else {
          if (response.message is String) {
            emit(ResetErrorState(errMsg: response.message));
            return;
          }
          if (response.message[0] == "Old Password is must be strong") {
            emit(ResetErrorState(errMsg: "Old Password doesn't match"));
          } else {
            emit(ResetErrorState(errMsg: response.message[0]));
          }
        }
      } catch (e) {
        emit(ResetErrorState(errMsg: "No internet connection"));
      }
    }
  }

  changeOldPasswordVisibility() {
    isOldPasswordObscure = !isOldPasswordObscure;
  }

  changeNewPasswordVisibility() {
    isNewPasswordObscure = !isNewPasswordObscure;
  }
}
