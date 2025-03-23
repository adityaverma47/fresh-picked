import 'package:get/get.dart';
import 'dart:convert';
import '../../../core/app_export.dart';
import '../../../core/utils/constants.dart';
import '../../../data/models/ChatModels/conversation_model.dart';
import '../../../data/models/ChatModels/message_model.dart';
import '../../../services/socket_client.dart';

class ChatController extends GetxController {
  var conversations = <Conversation>[].obs;
  var messages = <Message>[].obs;
  var isLoading = false.obs;

  // Initialize your socket service singleton
  final SocketService socketService = SocketService();
  final secureStorage = FlutterSecureStorage();

  @override
  void onInit() async {
    super.onInit();

    // Read token from secure storage
    String? token = await secureStorage.read(key: Constants.accessToken);
    print("Token: $token");

    if (token == null || token.isEmpty) {
      print("Error: Access token is null or empty.");
      return;
    }

    // Initialize socket and connect
    await _initializeSocket(token);

    // Listen for new messages if the socket is connected
    if (socketService.isConnected) {
      socketService.on('newMessage', _handleNewMessage);
    } else {
      print('Socket not connected.');
    }
  }

  // Function to initialize socket asynchronously
  Future<void> _initializeSocket(String token) async {
    await socketService.initialize(token: token);
    // Ensure socket is connected
    if (socketService.isConnected) {
      print('Socket connected successfully.');
    } else {
      print('Error: Socket failed to connect.');
    }
  }

  @override
  void onClose() {
    socketService.off('newMessage');
    super.onClose();
  }

  /// Get conversations via socket using ack
  void getConversations() {
    if (socketService.isConnected) {
      isLoading.value = true;
      socketService.emitWithAck('get-conversations', {}, (response) {
        print('get-conversations ack: $response');
        try {
          // Assuming the response is a list of conversation JSON objects.
          var data = response as List;
          conversations.value =
              data.map((e) => Conversation.fromJson(e)).toList();
        } catch (e) {
          print("Error parsing conversations: $e");
        }
        isLoading.value = false;
      });
    } else {
      print("Error: Socket is not connected.");
    }
  }

  /// Get messages for a conversation via socket using ack
  void getConversation(String conversationId) {
    if (socketService.isConnected) {
      isLoading.value = true;
      socketService.emitWithAck(
        'get-conversation',
        {'conversationId': conversationId},
            (response) {
          print('get-conversation ack: $response');
          try {
            // Assuming response contains a JSON with a 'messages' field.
            var data = response;
            messages.value = (data['messages'] as List)
                .map((e) => Message.fromJson(e))
                .toList();
          } catch (e) {
            print("Error parsing messages: $e");
          }
          isLoading.value = false;
        },
      );
    } else {
      print("Error: Socket is not connected.");
    }
  }

  /// Send a message via socket using ack
  void sendMessage(String vegitableId, String sellerId, String messageText) {
    if (socketService.isConnected) {
      final messageData = {
        'vegitableId': vegitableId,
        'sellerId': sellerId,
        'message': messageText,
      };

      socketService.emitWithAck('send-message', messageData, (response) {
        print('send-message ack: $response');
      });
    } else {
      print("Error: Socket is not connected.");
    }
  }

  // Socket event handler for incoming messages.
  void _handleNewMessage(dynamic data) {
    var decodedData = jsonDecode(data);
    final newMessage = Message.fromJson(decodedData);
    messages.add(newMessage);
    update();
  }
}
