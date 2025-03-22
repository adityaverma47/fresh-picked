import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fresh_picked/core/utils/flutter_toast.dart';
import 'package:fresh_picked/data/models/HomeProductModel/home_product_model.dart';
import '../../data/models/AddProductModel/add_product_model.dart';
import '../../data/models/AddToFavModel/add_fav_model.dart';
import '../../data/models/AllFavodel/all_fav_model.dart';
import '../../data/models/AllVegetablesModel/all_vegetables_model.dart';
import '../../data/models/CommonModel/common_model.dart';
import '../../data/models/LoginModel/login_model.dart';
import '../../data/models/ProfileModel/profile_model.dart';
import '../../data/models/RegisterModel/register_model.dart';
import '../../data/models/RemFromFavModel/remove_fav_model.dart';
import '../utils/constants.dart';
import 'api_constants.dart';
import 'api_repository.dart';

class ApiService implements ApiRepository {
  final Dio dio;

  ApiService({required this.dio});

  final secureStorage = const FlutterSecureStorage();

  @override
  Future<LoginModel> login(Map<String, String> request) async {
    try {
      final response = await dio.post(ApiConstants.userLogin, data: request);
      print("LoginResponse:${response.statusCode}");
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
        message: Message_Utils.displayToast(e.toString()),
      );
    }
  }

  @override
  Future<RegisterModel> register(Map<String, String> request) async {
    try {
      final response = await dio.post(ApiConstants.userRegister, data: request);
      print("LoginResponse1:${response.data}");
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
        message: Message_Utils.displayToast(e.toString()),
      );
    }
  }

  @override
  Future<CommonModel> forgotPassword(Map<String, String> request) async {
    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        throw Exception('Token is missing in the request map.');
      }
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

  @override
  Future<HomeProductModel> getHomeProducts(
      String latitude, String longitude) async {
    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        throw Exception('Token is missing in the request map.');
      }

      Response response = await dio.get(
        ApiConstants.getHomeData,
        queryParameters: {
          Constants.latitude: latitude,
          Constants.longitude: longitude,
        },
      );
      if (response.statusCode == 200) {
        return HomeProductModel.fromJson(response.data);
      } else {
        return HomeProductModel(
            success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return HomeProductModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return HomeProductModel(success: false, message: "server error");
  }

  @override
  Future<AddProductModel> addVegetables(FormData request) async {
    try {
      Response response = await dio.post(ApiConstants.addProduct, data: request);
      if (response.statusCode == 201) {
        return AddProductModel.fromJson(response.data);
      } else {
        return AddProductModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return AddProductModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return AddProductModel(success: false, message: "server error");
  }

  @override
  Future<AllVegetablesModel> getAllVegetables(String latitude,String longitude) async {
    try {
      String? token = await secureStorage.read(key: Constants.accessToken);
      if (token == null || token.isEmpty) {
        throw Exception('Token is missing in the request map.');
      }

      Response response = await dio.get(
        ApiConstants.getAllVegetables,
        queryParameters: {
          Constants.latitude: latitude,
          Constants.longitude: longitude,
        },
      );
      if (response.statusCode == 200) {
        return AllVegetablesModel.fromJson(response.data);
      } else {
        return AllVegetablesModel(
            success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return AllVegetablesModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return AllVegetablesModel(success: false, message: "server error");
  }

  @override
  Future<AddToFavModel> addToFavourites(Map<String,dynamic> request) async {
    try {
      Response response =
          await dio.post(ApiConstants.addToFav,data: request);
      if (response.statusCode == 201) {
        return AddToFavModel.fromJson(response.data);
      } else {
        return AddToFavModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return AddToFavModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return AddToFavModel(success: false, message: "server error");
  }

  @override
  Future<AllFavModel> getAllFavourites(Map<String,dynamic> request) async {
    try {
      Response response =
          await dio.get(ApiConstants.getAllFav,data: request);
      if (response.statusCode == 200) {
        return AllFavModel.fromJson(response.data);
      } else {
        return AllFavModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return AllFavModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return AllFavModel(success: false, message: "server error");
  }

  @override
  Future<RemoveFromFavModel> removeFromFav(Map<String, dynamic> request) async{
    try {
      Response response =
          await dio.delete(ApiConstants.removeFromFav,data: request);
      if (response.statusCode == 200) {
        return RemoveFromFavModel.fromJson(response.data);
      } else {
        return RemoveFromFavModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return RemoveFromFavModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return RemoveFromFavModel(success: false, message: "server error");
  }

  @override
  Future<ProfileModel> updateProfile(FormData request) async {
    try {
      Response response = await dio.patch(ApiConstants.updateProfile, data: request);
      if (response.statusCode == 200) {
        return ProfileModel.fromJson(response.data);
      } else {
        return ProfileModel(success: false, message: response.data["message"]);
      }
    } on DioException catch (e) {
      if (e.response != null) {
        return ProfileModel(
            success: false, message: e.response?.data["message"]);
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    return ProfileModel(success: false, message: "server error");
  }


}
