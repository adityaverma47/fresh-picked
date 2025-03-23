import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/ChatModels/conversation_model.dart';
import 'controller/chat_controller.dart';

class ChatScreen extends GetView<ChatController> {
  final TextEditingController messageController = TextEditingController();
  var selectedConversation = Rxn<Conversation>();

  @override
  Widget build(BuildContext context) {
    controller.getConversations();

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => selectedConversation.value == null
            ? Text("Chats")
            : Text(selectedConversation.value!.vegitable?.name ?? "Unknown")),
        leading: Obx(() => selectedConversation.value != null
            ? IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => selectedConversation.value = null,
        )
            : SizedBox()),
      ),
      body: Obx(() => selectedConversation.value == null
          ? _buildConversationList()
          : _buildChatDetail(selectedConversation.value!)),
    );
  }

  Widget _buildConversationList() {
    return Obx(() => controller.isLoading.value
        ? Center(child: CircularProgressIndicator())
        : ListView.builder(
      itemCount: controller.conversations.length,
      itemBuilder: (context, index) {
        var conversation = controller.conversations[index];
        return ListTile(
          title: Text(conversation.vegitable?.name ?? "Unknown"),
          subtitle: Text(
              "Buyer: ${conversation.buyer?.fullName ?? "Unknown"} | Seller: ${conversation.seller?.fullName ?? "Unknown"}"),
          onTap: () {
            selectedConversation.value = conversation;
            controller.getConversation(conversation.id ?? "");
          },
        );
      },
    ));
  }

  Widget _buildChatDetail(Conversation conversation) {
    return Column(
      children: [Expanded(
        child: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: controller.messages.length,
          itemBuilder: (context, index) {
            var message = controller.messages[index];
            return ListTile(
              title: Text(message.text ?? ""), // Provide default if null\n              subtitle: Text("From: ${message.sender ?? "Unknown"}"),
            );
          },
        )),
      ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: messageController,
                  decoration: InputDecoration(hintText: "Type a message"),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () {
                  if (messageController.text.trim().isNotEmpty) {
                    controller.sendMessage(
                      conversation.id ?? "",
                      conversation.seller?.id ?? "",
                      messageController.text.trim(),
                    );
                    messageController.clear();
                  }
                },
              )
            ],
          ),
        )
      ],
    );
  }
}