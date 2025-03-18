import 'dart:io';
import 'package:fresh_picked/views/profile/controller/profile_controller.dart';
import '../../core/app_export.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    var secureStorage = const FlutterSecureStorage();
    var storage = GetStorage();

    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55,
        title: Text(
          "Personal Details",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
        ),
        isBackBtnVisible: true,
        onTap: () {
          Get.offAllNamed(AppRoutes.bottomBar);
        },
        centerTitle: true,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 30.w),
            child: GestureDetector(
              onTap: () {
                CustomDialogUtils.showCustomDialog(
                  title: "LogOut",
                  message: "Are you sure you want to logout?",
                  onConfirm: () async {
                    await storage.erase();
                    await secureStorage.deleteAll();
                    Get.offAllNamed(AppRoutes.loginScreen);
                  },
                  onCancel: () {
                    Get.back();
                  },
                  confirmText: "Yes",
                  cancelText: "No",
                );
              },
              child: const Icon(Icons.logout, size: 30),
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),

              // Profile Picture
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(() {
                        String? avatarPath = storage.read(Constants.avatar);
                        return CircleAvatar(
                          radius: 50,
                          backgroundImage: controller.selectedImage.value != null
                              ? FileImage(controller.selectedImage.value!)
                              : (avatarPath != null && avatarPath.isNotEmpty
                              ? FileImage(File(avatarPath))
                              : const AssetImage(ImageConstants.tomato)) as ImageProvider,
                        );
                      }),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () => controller.pickImage(),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: const Icon(Icons.camera_alt, color: Colors.green, size: 24),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 18.h),
              _buildLabel("Name"),
              CustomTextFormField(controller: controller.nameController.value),
              SizedBox(height: 12.h),

              _buildLabel("Email"),
              CustomTextFormField(controller: controller.emailController.value, readOnly: true),
              SizedBox(height: 12.h),

              _buildLabel("Number"),
              CustomTextFormField(
                controller: controller.phoneController.value,
                maxLength: 10,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 12.h),

              _buildLabel("Date of Birth"),
              GestureDetector(
                onTap: () => controller.selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: controller.dobController.value,
                    hintText: "Select Date of Birth",
                    suffix: const Icon(Icons.calendar_today, color: ColorConstants.black),
                  ),
                ),
              ),
              SizedBox(height: 12.h),

              _buildLabel("Gender"),
              Obx(
                    () => Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstants.primaryColor),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: controller.selectedGender.value.isEmpty
                          ? null
                          : controller.selectedGender.value,
                      hint: Text(
                        "Select Gender",
                        style: TextStyle(fontSize: 16.sp, color: ColorConstants.black),
                      ),
                      isExpanded: true,
                      items: ["Male", "Female", "Other"]
                          .map((gender) => DropdownMenuItem(
                        value: gender,
                        child: Text(gender, style: TextStyle(fontSize: 16.sp)),
                      ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.updateGender(value);
                        }
                      },
                    ),
                  ),
                ),
              ),

              SizedBox(height: 25.h),

              // Save Button
              Obx(
                    () => CustomButtonBottom(
                  loading: controller.isLoading.value,
                  margin: EdgeInsets.symmetric(horizontal: 55.h),
                  height: 40.h,
                  text: "Save",
                  onTap: () {
                    controller.updateProfile();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16.sp,
        color: ColorConstants.black,
        fontFamily: AppFonts.inter,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
