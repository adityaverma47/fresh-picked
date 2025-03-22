import 'package:flutter/services.dart';
import 'package:fresh_picked/views/addProduct/controller/add_product_controller.dart';
import '../../core/app_export.dart';

class AddProductScreen extends GetView<AddProductController> {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55,
        title: Text(
          "Add Product",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w800,
            fontFamily: AppFonts.abhayaLibre
          ),
        ),
        centerTitle: false,
        isBackBtnVisible: true,
        onTap: () {
          Get.offAllNamed(AppRoutes.bottomBar);
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
          child: Form(
            key: formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextFormField(
                    controller: controller.nameController.value,
                    hintText: "Enter Product name",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Vegetable name is required";
                      } else if (value.length > 150) {
                        return "Title cannot exceed 150 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    controller: controller.priceController.value,
                    hintText: "Enter Product price",
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    textInputType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        // Add dollar symbol if the value doesn't already have it
                        if (newValue.text.isNotEmpty && !newValue.text.startsWith("\$")) {
                          return TextEditingValue(
                            text: "\$${newValue.text}", // Prefix the value with $
                            selection: TextSelection.collapsed(offset: newValue.text.length + 1),
                          );
                        }
                        return newValue; // Return the unchanged value if it starts with $
                      }),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Price is required";
                      }
                      if (!value.startsWith("\$")) {
                        return "Price must start with \$ symbol";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    controller: controller.addressController.value,
                    hintText: "Enter your address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Address is required";
                      } else if (value.length > 500) {
                        return "Description cannot exceed 500 characters";
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomTextFormField(
                    controller: controller.descriptionController.value,
                    hintText: "Enter Product description",
                    labelAlign: TextAlign.left,
                    maxLines: 10,
                    minLines: 4,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Description is required";
                      } else if (value.length > 1500) {
                        return "Description cannot exceed 1500 characters";
                      }
                      return null;
                    },
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                  SizedBox(height: 15.h),
                  // Image pick button

                  CustomButtonBottom(
                    margin: EdgeInsets.only(right: 200.w),
                    onTap: () {
                     controller.pickImage();
                    },
                    text: "Pick Image",
                  ),

                  SizedBox(
                    height: 15.h,
                  ),
                  Obx(() {
                    return controller.pickedImage.value == null
                        ? Container(
                            width: 100.w,
                            height: 100.h,
                            color: Colors.grey[300], // Placeholder color
                            child: const Icon(Icons
                                .camera_alt), // Show camera icon as placeholder
                          )
                        : Container(
                            width: 150.w,
                            height: 150.h,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(controller.pickedImage.value!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                  }),
                  SizedBox(
                    height: 25.h,
                  ),
                  Obx(() => CustomButtonBottom(
                    onTap: () {
                      if (formKey.currentState?.validate() ?? false &&
                          controller.validateImage() == null) {
                        controller.addVegetables();
                      }
                    },
                    loading: controller.isLoading.value, // Show loader
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    height: 45.h,
                    text: "Submit",
                  )),
                ]),
          ),
        ),
      ),
    );
  }
}
