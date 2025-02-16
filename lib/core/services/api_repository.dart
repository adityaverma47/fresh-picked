import 'package:fresh_picked/data/models/RegisterModel/register_model.dart';

import '../../data/models/CommonModel/common_model.dart';
import '../../data/models/LoginModel/login_model.dart';

abstract class ApiRepository {

  Future<LoginModel> login(Map<String,String> request);
  Future<RegisterModel> register(Map<String,String> request);
  Future<CommonModel> forgotPassword(Map<String,String> request);
  Future<CommonModel> verifyOtp(Map<String,String> request);
  Future<CommonModel> resetPassword(Map<String,String> request);
}