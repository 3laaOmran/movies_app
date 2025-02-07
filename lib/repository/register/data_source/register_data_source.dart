import 'package:movies_app/models/register_model.dart';


abstract class RegisterDataSource {
 Future<RegisterModel> register(String name,String email,
     String password,String rePassword,String phone,int avaterId);
}