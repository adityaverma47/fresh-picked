import 'package:fresh_picked/chat/controller/chat_controller.dart';
import 'package:fresh_picked/core/app_export.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatController());
  }

}