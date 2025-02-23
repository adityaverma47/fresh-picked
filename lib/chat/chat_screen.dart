import '../core/app_export.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55.h,
        title: Text(
          "Chat",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
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
