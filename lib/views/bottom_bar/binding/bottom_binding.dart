import 'package:fresh_picked/core/app_export.dart';
import 'package:fresh_picked/views/addProduct/controller/add_product_controller.dart';
import 'package:fresh_picked/views/favourites/controller/favourites_controller.dart';
import 'package:fresh_picked/views/profile/controller/profile_controller.dart';
import '../../chat/controller/chat_controller.dart';
import '../controller/bottom_controller.dart';

class BottomBinding extends Bindings {

  @override
  void dependencies() {
   Get.lazyPut(() => BottomController());
   Get.lazyPut<FavouritesController>(() => FavouritesController());
   Get.lazyPut<AddProductController>(() => AddProductController());
   // Get.lazyPut<ChatController>(() => ChatController());
   Get.lazyPut<ProfileController>(() => ProfileController());
  }

}