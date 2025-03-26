import 'package:flutter/material.dart';
import 'package:fresh_picked/core/app_export.dart';
import 'package:get/get.dart';
import '../../../data/models/ChatModels/conversation_model.dart';
import 'controller/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  final TextEditingController messageController = TextEditingController();
  final Rxn<Conversation> selectedConversation = Rxn<Conversation>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 55.h,
        title: Text("Seller"),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              return selectedConversation.value == null
                  ? _buildConversationList()
                  : _buildChatDetail(selectedConversation.value!);
            }),
          ),
          Obx(() {
            return selectedConversation.value != null
                ? _buildMessageInput(selectedConversation.value!)
                : SizedBox.shrink(); // Hide when no conversation is selected
          }),
        ],
      ),
    );
  }

  /// **Conversations List**
  Widget _buildConversationList() {
    return Obx(() {
      return ListView.builder(
        itemCount: controller.conversations.length,
        itemBuilder: (context, index) {
          var conversation = controller.conversations[index];
          return ListTile(
            title: Text(conversation.vegitable?.name ?? "Unknown"),
            subtitle: Text(
              "Buyer: ${conversation.buyer?.fullName ?? "Unknown"} | Seller: ${conversation.seller?.fullName ?? "Unknown"}",
            ),
            onTap: () {
              selectedConversation.value = conversation;
              if (controller.messages.isEmpty) {
                controller.getConversation(conversation.id ?? "");
              }
            },
          );
        },
      );
    });
  }

  /// **Chat Messages List**
  Widget _buildChatDetail(Conversation conversation) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            return ListView.builder(
              itemCount: controller.messages.length,
              itemBuilder: (context, index) {
                var message = controller.messages[index];
                return ListTile(
                  title: Align(
                    alignment: message.sender == "you"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: message.sender == "you"
                            ? Colors.blue[200]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(message.text ?? ""),
                    ),
                  ),
                  subtitle: Align(
                    alignment: message.sender == "you"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Text("From: ${message.sender ?? "Unknown"}"),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  /// **Message Input Field (Fixed at Bottom)**
  Widget _buildMessageInput(Conversation conversation) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              final text = messageController.text.trim();
              if (text.isNotEmpty) {
                controller.sendMessage(
                  conversation.id ?? "",
                  conversation.seller?.id ?? "",
                  text,
                );
                messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
