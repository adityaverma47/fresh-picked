import '../../core/app_export.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
    );
  }
}
