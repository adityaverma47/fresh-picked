import 'package:fresh_picked/core/app_export.dart';

import '../controller/chat_controller.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }

}