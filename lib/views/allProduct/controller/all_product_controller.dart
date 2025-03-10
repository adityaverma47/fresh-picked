import 'package:dio/dio.dart';
import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/dashboard/controller/dashboard_controller.dart';

import '../../../data/models/AllVegetablesModel/all_vegetables_model.dart';

class AllProductController extends GetxController {
  RxBool isLoading = false.obs;
  final ApiService apiService = ApiService(dio: DioClient().getDio());
  final secureStorage = const FlutterSecureStorage();
  RxList<Vegitables> vegetableList = <Vegitables>[].obs;
  final storage = GetStorage();
  var myLatitude = 0.0.obs;
  var myLongitude = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadFromLocalStorage();
   fetchAllVegetables();
  }

  void _loadFromLocalStorage() {
    double? storedLatitude = storage.read(Constants.latitude);
    double? storedLongitude = storage.read(Constants.longitude);

    if (storedLatitude != null && storedLongitude != null) {
      myLatitude.value = storedLatitude;
      myLongitude.value = storedLongitude;
    } else {
      if (kDebugMode) {
        print("Found no location");
      }
    }
  }

  Future<void> fetchAllVegetables() async{
    isLoading.value = true;

    try{
      String? token = await secureStorage.read(key: Constants.accessToken);

      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print("Token is missing. Cannot fetch wishlist.");
        }
        Message_Utils.displayToast("Token is missing. Please log in.");
        return;
      }

      var response = await apiService.getAllVegetables(myLatitude.value.toString(), myLongitude.value.toString());

      if(response.success == true) {
        vegetableList.value = response.data!.vegitables!;
        CustomSnackBar(response.message.toString(), "S");
      } else {
        CustomSnackBar(response.message.toString(), "E");
      }

    }on DioException catch(e){
      Message_Utils.displayToast(e.toString());
    } catch (e){
      Message_Utils.displayToast(e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }

  void navigateToDetailScreen(Vegitables product){
   Get.toNamed(AppRoutes.productDetailScreen, arguments: {
     'title': product.name,
     'id': product.sId,
     'image': product.vegitableImage.toString(),
     'price': product.cost.toString(),
     'description': product.description,
     'sellerId': product.seller,
     // 'distance':product.distance!.toDouble()
   });
  }
}