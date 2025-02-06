import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/api/api_constants.dart';
import 'package:movies_app/models/login_model.dart';
import 'package:movies_app/repository/login/data_source/login_remote_data_source.dart';

import '../../../api/end_points.dart';

@Injectable(as: LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future<LoginModel?> login(String name, String password) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.loginEndPoint);

    try {
      var response =
          await http.post(url, body: {'email': name, 'password': password});
      return LoginModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
