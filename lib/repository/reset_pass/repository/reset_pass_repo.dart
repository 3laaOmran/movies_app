import '../../../models/reset_pass_model.dart';

abstract class ResetPassRepo {
  Future<ResetPassModel?> ChangePassword(
      String oldPass, String newPass, String token);
}
