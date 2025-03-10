import 'package:dio/dio.dart';
import 'package:fresh_picked/data/models/AllVegetablesModel/all_vegetables_model.dart';
import 'package:fresh_picked/data/models/HomeProductModel/home_product_model.dart';
import 'package:fresh_picked/data/models/RegisterModel/register_model.dart';
import '../../data/models/AddProductModel/add_product_model.dart';
import '../../data/models/AddToFavModel/add_fav_model.dart';
import '../../data/models/AllFavodel/all_fav_model.dart';
import '../../data/models/CommonModel/common_model.dart';
import '../../data/models/LoginModel/login_model.dart';
import '../../data/models/RemFromFavModel/remove_fav_model.dart';

abstract class ApiRepository {

  Future<LoginModel> login(Map<String,String> request);
  Future<RegisterModel> register(Map<String,String> request);
  Future<CommonModel> forgotPassword(Map<String,String> request);
  Future<CommonModel> verifyOtp(Map<String,String> request);
  Future<CommonModel> resetPassword(Map<String,String> request);
  Future<HomeProductModel> getHomeProducts(String latitude,String longitude);
  Future<AddProductModel> addVegetables(FormData request);
  Future<AllVegetablesModel> getAllVegetables(String latitude,String longitude);  // Pending
  Future<AddToFavModel> addToFavourites(Map<String,dynamic> request);
  Future<AllFavModel> getAllFavourites(Map<String,dynamic> request);
  Future<RemoveFromFavModel> removeFromFav(Map<String, dynamic> request);
  Future<CommonModel> updateProfile(FormData request);
}