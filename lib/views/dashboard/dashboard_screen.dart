import '../../core/app_export.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorConstants.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text(" Welcome Home Screen",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))
        ],
      ),
    );
  }
}
