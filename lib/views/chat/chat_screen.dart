import '../../core/app_export.dart';
import 'controller/chat_controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChatController controller = Get.put(ChatController());

    return Scaffold(
      backgroundColor: ColorConstants.homeBackGroundColor,
      appBar: CustomAppBar(
        height: 55.h,
        title: Text(
          "Chat",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        isBackBtnVisible: true,
        onTap: () {
          Get.offAllNamed(AppRoutes.bottomBar);
        },
      ),
      body: Column(
        children: [
          // Chat Messages
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: controller.messages.length,
              reverse: true,
              itemBuilder: (context, index) {
                final message = controller.messages[index];
                return Align(
                  alignment: message.isSender
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                    margin: EdgeInsets.symmetric(vertical: 4.h),
                    decoration: BoxDecoration(
                      color: message.isSender ? Colors.green : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(fontSize: 16.sp, color: Colors.black),
                    ),
                  ),
                );
              },
            )),
          ),

          // Chat Input Field
          _buildChatInput(controller),
        ],
      ),
    );
  }

  Widget _buildChatInput(ChatController controller) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: controller.messageController,
              hintText: "Type a message...",
              maxLines: null,
              minLines: 1,
              textInputAction: TextInputAction.done, // Set action to 'done'
              onChanged: (value) {
                if (value.endsWith("\n")) {  // Check if user pressed Enter
                  controller.sendMessage();
                }
              },
              suffix: GestureDetector(
                onTap: () => controller.sendMessage(),
                child: Padding(
                  padding: EdgeInsets.all(10.w),
                  child: const Icon(Icons.send, color: Colors.green),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
