import 'package:dio/dio.dart';
import 'package:fresh_picked/core/utils/flutter_toast.dart';
import '../../data/models/CommonModel/common_model.dart';
import '../../data/models/LoginModel/login_model.dart';
import '../../data/models/RegisterModel/register_model.dart';
import 'api_constants.dart';
import 'api_repository.dart';

class ApiService implements ApiRepository {
  final Dio dio;

  ApiService({required this.dio});

  @override
  Future<LoginModel> login(Map<String, String> request) async {
    try {
      final response = await dio.post(ApiConstants.userLogin, data: request);

      if (response.statusCode == 200) {
        return LoginModel.fromJson(response.data);
      } else {
        return LoginModel(
          success: false,
          message: response.data['message'] ??
              "Unexpected error occurred. Status Code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      return LoginModel(
        success: false,
        message: e.response?.data['message'] ??
            e.response?.statusMessage ??
            "Server error occurred. Please try again.",
      );
    } catch (e) {
      return LoginModel(
        success: false,
        message:  Message_Utils.displayToast(e.toString()),
      );
    }
  }

  @override
  Future<RegisterModel> register(Map<String, String> request) async {
    try {
      final response = await dio.post(ApiConstants.userRegister, data: request);
      if (response.statusCode == 201) {
        return RegisterModel.fromJson(response.data);
      } else {
        return RegisterModel(
          success: false,
          message: response.data['message'] ??
              "Unexpected error occurred. Status Code: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      return RegisterModel(
        success: false,
        message: e.response?.data['message'] ?? "Server error",
      );
    } catch (e) {
      return RegisterModel(
        success: false,
        message:  Message_Utils.displayToast(e.toString()),
      );
    }
  }

  @override
  Future<CommonModel> forgotPassword(Map<String, String> request) async {
    try {
      Response response =
      await dio.post(ApiConstants.forgotPasswordMethod, data: request);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return CommonModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return CommonModel(success: false, message: "server error");
  }

  @override
  Future<CommonModel> verifyOtp(Map<String, String> request) async {
    try {
      Response response =
      await dio.post(ApiConstants.verifyOtpMethod, data: request);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return CommonModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return CommonModel(success: false, message: "server error");
  }

  @override
  Future<CommonModel> resetPassword(Map<String, String> request) async {
    try {
      Response response =
      await dio.post(ApiConstants.resetPasswordMethod, data: request);
      if (response.statusCode == 200) {
        return CommonModel.fromJson(response.data);
      } else {
        return CommonModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return CommonModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return CommonModel(success: false, message: "server error");
  }

  }
