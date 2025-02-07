import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/repository/user/data_source/user_remote_data_source.dart';

import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';
import '../../../utils/helpers/cash_helper.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel?> getUserData() async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.getUserData);

    try {
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer ${CashHelper.getData(key: "token")}'
      });

      if (response.statusCode != 200) {
        throw Exception("Failed to load movies: ${response.statusCode}");
      }

      var jsonResponse = jsonDecode(response.body);
      return UserModel.fromJson(jsonResponse);
    } catch (e) {
      print("Error: $e");
      rethrow;
    }
  }
}
