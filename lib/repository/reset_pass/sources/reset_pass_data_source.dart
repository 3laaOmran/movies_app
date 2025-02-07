import '../../../models/reset_pass_model.dart';

abstract class ResetPassDataSource {
  Future<ResetPassModel?> ChangePassword(
      String oldPass, String newPass, String token);
}
