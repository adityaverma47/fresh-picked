import 'package:app_settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/app_export.dart';
import '../../../data/models/HomeProductModel/home_product_model.dart';

class DashboardController extends GetxController {

  final Rx<PermissionStatus> _permissionStatus = PermissionStatus.denied.obs;
  RxBool allPermissionGranted = false.obs;
  Rx<Position?> currentPosition = Rx<Position?>(null);
  final storage = GetStorage();
  final secureStorage = const FlutterSecureStorage();
  RxBool isLoading = false.obs;
  final ApiService apiService = ApiService(dio: DioClient().getDio());
  var myLatitude = 0.0.obs;
  var myLongitude = 0.0.obs;
  RxList<FivekMRangeProducts> productsList = <FivekMRangeProducts>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    permissionChecker();
    _loadFromLocalStorage();
    fetchAllHomeData();
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

  Future<void> permissionChecker() async {

    try {
      _permissionStatus.value = await Permission.location.request();
      print("permission${_permissionStatus.value}");
      if (_permissionStatus.value.isDenied) {
        _permissionStatus.value = await Permission.locationWhenInUse.request();
        _showPermissionDialog(
          "Location Permission Denied",
          "Location access is required to use this feature. Please enable it in the app settings.",
        );
        return;
      }

      if (_permissionStatus.value.isPermanentlyDenied) {
        _showPermissionDialog(
          "Permission Permanently Denied",
          "Location access is permanently denied. Please enable it in the app settings.",
        );
        return;
      }

      await _getUserLocation();
      allPermissionGranted.value = true;
      // Get.offAllNamed(AppRoutes.bottomBar);

    } catch (e) {
      Message_Utils.displayToast("Error requesting permissions: $e");
      throw Exception(e);
    }
  }

  Future<void> _getUserLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _showPermissionDialog(
          "Location Services Disabled",
          "Location services are disabled. Please enable them in the settings.",
        );
        return;
        // throw Exception("Location services are disabled.");
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _showPermissionDialog(
            "Permission Permanently Denied",
            "Location access is permanently denied. Please enable it in app settings.",
          );
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _showPermissionDialog(
          "Permission Permanently Denied",
          "Location access is permanently denied. Please enable it in app settings.",
        );
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
      );

      currentPosition.value = position;
      if(currentPosition.value != null) {
        storage.write(Constants.latitude, position.latitude);
        storage.write(Constants.longitude, position.longitude);
        print("User Location: ${position.latitude}, ${position.longitude}");
        await _convertLatLngToAddress(position.latitude, position.longitude);

      }

    } catch (e) {
      print("Error getting user location: $e");
    }
  }
  Future<void> _convertLatLngToAddress(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;

        String address = "${place.locality},${place.administrativeArea}";
        print("User Address: $address");
        storage.write('address', address);
      }
    } catch (e) {
      print("Error converting lat/lng to address: $e");
    }
  }

  void _showPermissionDialog(String title, String message) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              AppSettings.openAppSettings(type: AppSettingsType.location);
            },
            child: const Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  Future<void> fetchAllHomeData() async {

    isLoading.value = true;
    try {
      String? token = await secureStorage.read(key: Constants.accessToken);

      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print("Token is missing. Cannot fetch wishlist.");
        }
        Message_Utils.displayToast("Token is missing. Please log in.");
        return;
      }

      HomeProductModel response = await apiService.getHomeProducts(myLatitude.value.toString(), myLongitude.value.toString());

      if (response.success == true) {
        productsList.value = response.data?.fivekMRangeProducts ?? [];
      } else {
        CustomSnackBar(response.message.toString(), "E");
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print("${e.response?.data["message"] ?? "Unknown error"}");
      }

    } catch (e) {
      Message_Utils.displayToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}