import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/repository/reset_pass/sources/reset_pass_data_source.dart';

import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';
import '../../../models/reset_pass_model.dart';

@Injectable(as: ResetPassDataSource)
class ResetPassDataSourceImpl extends ResetPassDataSource {
  @override
  Future<ResetPassModel?> ChangePassword(
      String oldPass, String newPass, String token) async {
    Uri url =
        Uri.https(ApiConstants.authBaseUrl, EndPoints.resetPasswordEndPoint);
    try {
      var response = await http.patch(
        url,
        body: {'oldPassword': oldPass, 'newPassword': newPass},
        headers: {'Authorization': 'Bearer $token'},
      );
      return ResetPassModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
