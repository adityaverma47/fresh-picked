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


  @override
  void onInit() {
    super.onInit();
    nameController.value.text = storage.read(Constants.fullName) ?? "";
    emailController.value.text = storage.read(Constants.email) ?? "";
    phoneController.value.text = storage.read(Constants.phone) ?? "";
    dobController.value.text = storage.read(Constants.dob) ?? "";
    selectedGender.value = storage.read(Constants.gender) ?? "";
    String? avatarPath = storage.read(Constants.avatar);
    if (avatarPath != null && avatarPath.isNotEmpty) {
      selectedImage.value = File(avatarPath);
    }
  }
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
      storage.write(Constants.dob, dobController.value.text);
    }
  }

  void updateGender(String value) {
    selectedGender.value = value;
    storage.write(Constants.gender, value);
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
        Constants.userId : storage.read(Constants.id),
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
        storage.write(Constants.fullName, nameController.value.text.trim());
        storage.write(Constants.phone, phoneController.value.text);
        storage.write(Constants.dob, dobController.value.text.trim());
        storage.write(Constants.gender, selectedGender.value);
        if (selectedImage.value != null) {
          storage.write(Constants.avatar, selectedImage.value!.path);
        }
        CustomSnackBar(response.message.toString(), "S");
      } else {
        CustomSnackBar(response.message.toString(), "E");
      }
    } catch (e) {
      Message_Utils.displayToast(e.toString());
    }
    finally {
      isLoading.value = false;
    }
  }
}
