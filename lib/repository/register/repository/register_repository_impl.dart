import 'package:injectable/injectable.dart';
import 'package:movies_app/models/register_model.dart';
import 'package:movies_app/repository/register/data_source/register_data_source.dart';
import 'package:movies_app/repository/register/repository/register_repository.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository{
  RegisterDataSource registerDataSource;
  RegisterRepositoryImpl({required this.registerDataSource});
  @override
  Future<RegisterModel> register(String name, String email,
      String password, String rePassword, String phone, int avaterId)async {
    var registerResponse= await registerDataSource.register(name, email, password, rePassword, phone, avaterId);
    return registerResponse;

  }
}