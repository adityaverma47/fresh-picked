import 'dart:io';
import 'package:fresh_picked/views/AddProduct/add_product_screen.dart';
import 'package:fresh_picked/views/profile/profile_screen.dart';

import '../../core/app_export.dart';
import '../chat/chat_screen.dart';
import '../dashboard/dashboard_screen.dart';
import '../favourites/favourites_screen.dart';
import 'controller/bottom_controller.dart';

class BottomScreen extends GetView<BottomController> {
  const BottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (controller.numberClick.value == 0) {
              controller.lastTime.value = DateTime.now();
              controller.numberClick.value++;
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Press Back Button Again to Exit'),
                ),
              );
            } else if (controller.numberClick.value == 1 &&
                DateTime.now().difference(controller.lastTime.value) <=
                    const Duration(seconds: 3)) {
              exit(0);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Press Back Button Again to Exit'
                  )));
              controller.numberClick.value = 0;
              controller.lastTime.value = DateTime.now();
              controller.numberClick.value++;
            }
          },
          child: IndexedStack(
            index: controller.tabIndex.value,
            children:   const [
              DashboardScreen(),
              FavouritesScreen(),
              AddProductScreen(),
              // ChatScreen(),
              ProfileScreen()
            ],
          ),
        );
      }),
      bottomNavigationBar: Obx(() {
        final controller = Get.find<BottomController>();
        return BottomNavigationBar(
          unselectedItemColor: ColorConstants.lightPrimaryColor,
          selectedItemColor: ColorConstants.primaryColor,
          unselectedFontSize: 10.sp,
          selectedFontSize: 12.sp,
          currentIndex: controller.tabIndex.value,
          onTap: (index) => controller.changeTabIndex(index),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 25,
          items: [
            BottomNavigationBarItem(
              icon: (controller.tabIndex.value == 0)
                  ? const Icon(Icons.home)
                  : const Icon(Icons.home_outlined),
              label: 'Home',
            ),

            BottomNavigationBarItem(
              icon: (controller.tabIndex.value == 1)
                  ? const Icon(Icons.favorite)
                  : const Icon(Icons.favorite_border),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: (controller.tabIndex.value == 2)
                  ? const Icon(Icons.add_box)
                  : const Icon(Icons.add),
              label: 'Add Product',
            ),
            // BottomNavigationBarItem(
            //   icon: (controller.tabIndex.value == 3)
            //       ? const Icon(Icons.chat_bubble)
            //       : const Icon(Icons.chat_bubble_outline),
            //   label: 'Chat',
            // ),
            BottomNavigationBarItem(
              icon: (controller.tabIndex.value == 4)
                  ? const Icon(Icons.person)
                  : const Icon(Icons.perm_identity),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
}
