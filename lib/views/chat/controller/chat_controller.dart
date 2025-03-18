import 'package:fresh_picked/core/app_export.dart';

class ChatController extends GetxController {
  var messages = <ChatMessage>[].obs;
  TextEditingController messageController = TextEditingController();

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.insert(
      0,
      ChatMessage(text: messageController.text.trim(), isSender: true),
    );

    messageController.clear();
  }
}

class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({required this.text, required this.isSender});
}
