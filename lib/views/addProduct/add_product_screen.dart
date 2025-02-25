import 'package:fresh_picked/views/addProduct/controller/add_product_controller.dart';
import '../../core/app_export.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AddProductController controller = Get.put(AddProductController());
    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55,
        title:  Text(
          "Add Product",
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        isBackBtnVisible: true,
        onTap: () {
          Get.back();
        },
      ),

      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomTextFormField(
                hintText: "Enter Product name",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              SizedBox(height: 15.h,),
              CustomTextFormField(
                hintText: "Enter Product price",
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              SizedBox(height: 15.h,),
              CustomTextFormField(
                hintText: "Enter your address",
                // labelText: "Enter Product price",
              ),
              SizedBox(height: 15.h,),
              CustomTextFormField(
                hintText: "Enter Product description",
                labelAlign: TextAlign.left,
              maxLines: 10,
              minLines: 4,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              SizedBox(height: 15.h),
              // Image pick button

              CustomButtonBottom(
                margin: EdgeInsets.only(right: 200.w),
                onTap: (){
                controller.pickImage();
              },text: "Pick Image",),

               SizedBox(height: 15.h,),
          Obx(() {
            return controller.pickedImage.value == null
                ? Container(
              width: 100.w,
              height: 100.h,
              color: Colors.grey[300], // Placeholder color
              child: const Icon(Icons.camera_alt), // Show camera icon as placeholder
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

              SizedBox(height: 25.h,),
              CustomButtonBottom(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                height: 45.h,text: "Submit",)
          ]
          ),
        ),
      ),
    );
  }
}
