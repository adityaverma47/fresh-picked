import 'package:app_settings/app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/app_export.dart';

class DashboardController extends GetxController {

  final Rx<PermissionStatus> _permissionStatus = PermissionStatus.denied.obs;
  RxBool allPermissionGranted = false.obs;


  @override
  void onInit() {
    super.onInit();
    permissionChecker();
  }

  Future<void> permissionChecker() async {

    try {
      _permissionStatus.value = await Permission.location.request();

      if (_permissionStatus.value.isDenied) {
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

      // await _getUserLocation();
      allPermissionGranted.value = true;
      // Get.offAllNamed(AppRoutes.bottomBar);

    } catch (e) {
      Message_Utils.displayToast("Error requesting permissions: $e");
      throw Exception(e);
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

  // Future<void> _getUserLocation() async {
  //   try {
  //     bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //     if (!serviceEnabled) {
  //       _showPermissionDialog(
  //         "Location Services Disabled",
  //         "Location services are disabled. Please enable them in the settings.",
  //       );
  //       return;
  //       // throw Exception("Location services are disabled.");
  //     }
  //
  //     LocationPermission permission = await Geolocator.checkPermission();
  //     if (permission == LocationPermission.denied) {
  //       permission = await Geolocator.requestPermission();
  //       if (permission == LocationPermission.denied) {
  //         _showPermissionDialog(
  //           "Permission Permanently Denied",
  //           "Location access is permanently denied. Please enable it in app settings.",
  //         );
  //         return;
  //       }
  //     }
  //
  //     if (permission == LocationPermission.deniedForever) {
  //       _showPermissionDialog(
  //         "Permission Permanently Denied",
  //         "Location access is permanently denied. Please enable it in app settings.",
  //       );
  //       return;
  //     }
  //
  //     Position position = await Geolocator.getCurrentPosition(
  //         locationSettings: const LocationSettings(accuracy: LocationAccuracy.high)
  //     );
  //
  //     currentPosition.value = position;
  //     if(currentPosition.value != null) {
  //       storage.write(Constants.latitude, position.latitude);
  //       storage.write(Constants.longitude, position.longitude);
  //       print("User Location: ${position.latitude}, ${position.longitude}");
  //     }
  //
  //   } catch (e) {
  //     print("Error getting user location: $e");
  //   }
  // }

  // void _showPermissionDialog(String title, String message) {
  //   Get.dialog(
  //     AlertDialog(
  //       title: Text(title),
  //       content: Text(message),
  //       actions: [
  //         TextButton(
  //           onPressed: () {
  //             Get.back();
  //           },
  //           child: Text("Cancel"),
  //         ),
  //         TextButton(
  //           onPressed: () {
  //             Get.back();
  //             AppSettings.openAppSettings(type: AppSettingsType.location);
  //           },
  //           child: const Text("Open Settings"),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}