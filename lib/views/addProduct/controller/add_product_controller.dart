import 'dart:io';
import 'package:fresh_picked/core/app_export.dart';
import 'package:image_picker/image_picker.dart';

class AddProductController extends GetxController {

  Rx<File?> pickedImage = Rx<File?>(null);
  final storage = GetStorage();
  final secureStorage = const FlutterSecureStorage();
  RxBool isLoading = false.obs;
  final ApiService apiService = ApiService(dio: DioClient().getDio());

  // RxTextEditingController for input fields
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> priceController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path); // Set the picked image
    }
  }

  Future<void> addVegetables() async {
    try{
      isLoading.value = true;

      String? token = await secureStorage.read(key: Constants.accessToken);

      if (token == null || token.isEmpty) {
        if (kDebugMode) {
          print("Token is missing. Cannot fetch wishlist.");
        }
        Message_Utils.displayToast("Token is missing. Please log in.");
        return;
      }
      
      // Prepare form data
      FormData request = FormData({
        "name": nameController.value.text.trim(),
        "cost": priceController.value.text.trim(),
        "description": descriptionController.value.text.trim(),
        "address": addressController.value.text.trim(),
        "latitude": storage.read(Constants.latitude),
        "longitude": storage.read(Constants.longitude),
        if (pickedImage.value != null)
          "vegitableImage": MultipartFile(
            pickedImage.value!.path,
            filename: pickedImage.value!.path.split('/').last,
          ),
      });


      // var response = await apiService.addVegetables(request);

    } catch(e){
      Message_Utils.displayToast(e.toString());
    }
  }
}
