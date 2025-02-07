import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:movies_app/models/register_model.dart';
import 'package:movies_app/repository/register/data_source/register_data_source.dart';
import 'package:http/http.dart' as http;
import '../../../api/api_constants.dart';
import '../../../api/end_points.dart';

@Injectable(as: RegisterDataSource)
class RegisterDataSourceImpl implements RegisterDataSource{

  @override
  Future<RegisterModel>register(String name, String email,
      String password, String rePassword, String phone, int avaterId)async {
    Uri url=Uri.https(ApiConstants.authBaseUrl,EndPoints.registerEndPoint);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'confirmPassword': rePassword,
          'phone': phone,
          'avaterId': avaterId,
        }),
      );


        var json = jsonDecode(response.body);
        return RegisterModel.fromJson(json);

    } catch (e) {
      throw Exception('Failed to register user: $e');
    }
  }
  }

  
