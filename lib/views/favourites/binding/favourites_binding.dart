import 'package:fresh_picked/core/app_export.dart';
import '../controller/favourites_controller.dart';

class FavouritesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FavouritesController());
  }
}
