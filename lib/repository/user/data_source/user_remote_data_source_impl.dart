import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:movies_app/models/user_model.dart';
import 'package:movies_app/repository/user/data_source/user_remote_data_source.dart';

import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  @override
  Future<UserModel?> getUserData() async {
    Uri url = Uri.https(ApiConstants.authBaseUrl, EndPoints.getUserData);

    try {
      var response = await http.get(url, headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3OWRjZWMzMjQ5OGE2ZTNjZjQ2MjBjNyIsImVtYWlsIjoib21yYW5AZ21haWwuY29tIiwiaWF0IjoxNzM4Mzk1NDEwfQ.tFz4sy3MYySvxLmxO1t-pO4ZbF4cdba7qBn7x1_AlHQ'
      });

      if (response.statusCode != 200) {
        throw Exception("Failed to load movies: ${response.statusCode}");
      }

      var jsonResponse = jsonDecode(response.body);
      return UserModel.fromJson(jsonResponse);
    } catch (e) {
      print("Error Ya 3sool: $e");
      rethrow;
    }
  }
}
