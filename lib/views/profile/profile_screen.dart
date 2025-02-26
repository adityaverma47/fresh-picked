import 'package:fresh_picked/core/utils/app_fonts.dart';
import 'package:fresh_picked/views/profile/controller/profile_controller.dart';
import '../../core/app_export.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());
    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55,
        title:  Text("Personal Details", style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500),),
        isBackBtnVisible: true,
        onTap: () {
          Get.back();
        },
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Obx(() => CircleAvatar(
                        radius: 50,
                        backgroundImage: controller.selectedImage.value != null
                            ? FileImage(controller.selectedImage.value!) as ImageProvider
                            : const AssetImage(ImageConstants.tomato), // Default image
                      )),
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
              SizedBox(height: 18.h,),
             _buildLabel("Name"),
              CustomTextFormField(),
              SizedBox(height: 12.h,),
              _buildLabel("Email"),
              CustomTextFormField(
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: 12.h,),
             _buildLabel("Number"),
              CustomTextFormField(
                maxLength: 10,
                textInputAction: TextInputAction.next,
                textInputType: TextInputType.phone,
              ),
              SizedBox(height: 12.h,),
              _buildLabel("Date of Birth"),
              GestureDetector(
                onTap: () => controller.selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextFormField(
                    controller: controller.dobController,
                    hintText: "Select Date of Birth",
                    suffix:  const Icon(Icons.calendar_today, color: ColorConstants.black),
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              _buildLabel("Gender"),
              Obx(() => Container(
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
                    hint: Text("Select Gender",
                        style: TextStyle(fontSize: 16.sp, color: ColorConstants.black)),
                    isExpanded: true,
                    items: ["Male", "Female", "Other"]
                        .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender, style: TextStyle(fontSize: 16.sp)),
                    ))
                        .toList(),
                    onChanged: (value) {
                      controller.selectedGender.value = value!;
                    },
                  ),
                ),
              )),

              SizedBox(height: 25.h,),
              CustomButtonBottom(
                margin: EdgeInsets.symmetric(horizontal: 55.h),
                height: 40.h,text: "Save",onTap: (){},)
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
