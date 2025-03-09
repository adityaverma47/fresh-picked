import 'package:fresh_picked/core/app_export.dart';

class ProductDetailController extends GetxController {
  RxString title = ''.obs;
  RxString id = ''.obs;
  RxString image = ''.obs;
  RxString price = ''.obs;
  RxString description = ''.obs;
  // RxString sellerId = ''.obs;
  RxDouble distance = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
  }

  void _loadArguments() {
    final arguments = Get.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      title.value = arguments['title']?.toString() ?? '';
      id.value = arguments['id']?.toString() ?? '';
      image.value = arguments['image']?.toString() ?? '';
      price.value = arguments['price']?.toString() ?? '';
      description.value = arguments['description']?.toString() ?? '';
      // sellerId.value = arguments['sellerId']?.toString() ?? '';

      // Parse distance as RxDouble
      distance.value = (arguments['distance'] is double)
          ? arguments['distance']
          : double.tryParse(arguments['distance'].toString()) ?? 0.0;
    } else {
      print("No arguments received");
    }
  }
}
