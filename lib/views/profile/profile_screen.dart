import '../../core/app_export.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 55,
        title: const Text("Personal Details", style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
        isBackBtnVisible: true,
        onTap: () {
          Get.back();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

        ],
      ),
    );
  }
}
