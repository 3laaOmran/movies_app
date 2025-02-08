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
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.getUserData);

    try {
      var response = await http.get(url, headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YTYwOTUzM2EwOWRjYWMwZTdmNzAwYyIsImVtYWlsIjoib21yYW5AZ21haWwuY29tIiwiaWF0IjoxNzM4OTM0NzQzfQ.ntqGzjo1aN4x9B2nGU5cV73cNYgqSHPjKFGBtblLdPo'
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
    required String avatarId,
  }) async {
    Uri url = Uri.parse("https://route-movie-apis.vercel.app/profile");

    try {
      var response = await http.patch(
        url,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YTYwOTUzM2EwOWRjYWMwZTdmNzAwYyIsImVtYWlsIjoib21yYW5AZ21haWwuY29tIiwiaWF0IjoxNzM4OTM0NzQzfQ.ntqGzjo1aN4x9B2nGU5cV73cNYgqSHPjKFGBtblLdPo'
        },
        body: {
          "name": name,
          "phone": phone,
          "avatarId": avatarId,
        },
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
