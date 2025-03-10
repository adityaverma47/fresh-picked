import 'dart:io';
import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/dashboard/controller/dashboard_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class AddProductController extends GetxController {

  Rx<File?> pickedImage = Rx<File?>(null);
  final storage = GetStorage();
  final secureStorage = const FlutterSecureStorage();
  RxBool isLoading = false.obs;
  final ApiService apiService = ApiService(dio: DioClient().getDio());

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  String? validateImage() {
    if (pickedImage.value == null) {
      return "Image is required";
    }
    return null;
  }

  Future<void> addVegetables() async {
    try {
      isLoading.value = true;

      String? token = await secureStorage.read(key: Constants.accessToken);

      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print("Token is missing. Cannot fetch wishlist.");
        }
        Message_Utils.displayToast("Token is missing. Please log in.");
        return;
      }

      dio.FormData formData = dio.FormData.fromMap({
        "name": nameController.value.text.trim(),
        "cost": priceController.value.text.trim(),
        "description": descriptionController.value.text.trim(),
        "address": addressController.value.text.trim(),
        "latitude": storage.read(Constants.latitude),
        "longitude": storage.read(Constants.longitude),
        'sellerId':storage.read(Constants.id),
        if (pickedImage.value != null)
          "vegitableImage": await dio.MultipartFile.fromFile(
            pickedImage.value!.path,
            filename: pickedImage.value!.path.split('/').last,
          ),
      });
      if (kDebugMode) {
        print("FormData: ${formData.fields}");
      }
      var response = await apiService.addVegetables(formData);
      if (response.success == true) {
        CustomSnackBar(response.message.toString(), "S");
        Get.find<DashboardController>().fetchAllHomeData();
        clearFields();
      } else {
        Message_Utils.displayToast("Failed to add product.");
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
  void clearFields() {
    nameController.value.clear();
    priceController.value.clear();
    addressController.value.clear();
    descriptionController.value.clear();
    pickedImage.value = null;
    update(); // Notify UI to update image preview
  }
}
