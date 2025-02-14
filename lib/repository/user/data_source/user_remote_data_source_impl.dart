import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/update_profile_model.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/repository/user/data_source/user_remote_data_source.dart';

import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';
import '../../../utils/helpers/cash_helper.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel?> getUserData() async {
    //String? token = await CashHelper.getData(key: "token");
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.getUserData);

    try {
      var response = await http.get(url, headers: {
        "Authorization":
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWUzYTcwYzY0ZjMzOWJlYjA5MWM2ZCIsImVtYWlsIjoiYW1ydGVzdEBnbWFpbC5jb20iLCJpYXQiOjE3Mzk0NzE0OTR9.oi4gjd7nAK3JxEs46KYfzAhqec8359jfTW8E2mr5lfI"
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

  @override
  Future<UpdateProfileModel?> updateUserData({
    required String name,
    required String phone,
    required int avatarId
  }) async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.getUserData);

    try {
      var response = await http.patch(
          url,
          headers: {
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YWUzYTcwYzY0ZjMzOWJlYjA5MWM2ZCIsImVtYWlsIjoiYW1ydGVzdEBnbWFpbC5jb20iLCJpYXQiOjE3Mzk0NzE0OTR9.oi4gjd7nAK3JxEs46KYfzAhqec8359jfTW8E2mr5lfI",
          },
          body: {
            "name": name,
            "phone": phone,
            "avaterId": avatarId.toString(),
          }
      );

      if (response.statusCode != 200) {
        throw Exception("Failed to update user data: ${response.statusCode}");
      }
      var jsonResponse = jsonDecode(response.body);
      return UpdateProfileModel.fromJson(jsonResponse);
    } catch (e) {
      print("Error updating user data: $e");
      rethrow;
    }
  }

}
