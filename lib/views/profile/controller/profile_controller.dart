import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/app_export.dart';
import 'package:dio/dio.dart' as dio;

class ProfileController extends GetxController {
  var selectedGender = "".obs;
  var selectedImage = Rxn<File>();
  var selectedDate = Rxn<DateTime>();
  final storage = GetStorage();
  final secureStorage = const FlutterSecureStorage();
  RxBool isLoading = false.obs;
  final ApiService apiService = ApiService(dio: DioClient().getDio());

  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneController = TextEditingController().obs;
  Rx<TextEditingController> dobController = TextEditingController().obs;

  // Function to select date
  Future<void> selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      selectedDate.value = pickedDate;
      dobController.value.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> updateProfile() async {
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
        "fullName": nameController.value.text.trim(),
        "phone": phoneController.value.text,
        "dateOfBirth": dobController.value.text.trim(),
        "gender": selectedGender.value,
        if (selectedImage.value != null)
          "avatar": await dio.MultipartFile.fromFile(
            selectedImage.value!.path,
            filename: selectedImage.value!.path.split('/').last,
          ),
      });

      var response = await apiService.updateProfile(formData);
      if (response.success == true) {
        CustomSnackBar(response.message.toString(), "S");
      } else {
        CustomSnackBar(response.message.toString(), "E");
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
  }
}
