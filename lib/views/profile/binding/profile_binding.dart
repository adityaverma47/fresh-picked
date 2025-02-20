import 'package:fresh_picked/views/profile/controller/profile_controller.dart';

import '../../../core/app_export.dart';

class ProfileBinding  extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileController());
  }

}