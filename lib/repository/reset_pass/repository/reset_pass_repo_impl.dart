import 'package:injectable/injectable.dart';
import 'package:movies_app/models/reset_pass_model.dart';
import 'package:movies_app/repository/reset_pass/repository/reset_pass_repo.dart';
import 'package:movies_app/repository/reset_pass/sources/reset_pass_data_source.dart';

@Injectable(as: ResetPassRepo)
class ResetPassRepoImpl implements ResetPassRepo {
  ResetPassDataSource dataSource;

  ResetPassRepoImpl({required this.dataSource});

  @override
  Future<ResetPassModel?> ChangePassword(
      String oldPass, String newPass, String token) {
    return dataSource.ChangePassword(oldPass, newPass, token);
  }
}
