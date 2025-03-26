import 'package:get/get.dart';
import 'dart:convert';
import '../../../core/app_export.dart';
import '../../../core/utils/constants.dart';
import '../../../data/models/ChatModels/conversation_model.dart';
import '../../../data/models/ChatModels/message_model.dart';
import '../../../services/socket_client.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChatController extends GetxController {
  var conversations = <Conversation>[].obs;
  var messages = <Message>[].obs;
  var isLoading = false.obs;

  // Initialize your socket service singleton.
  final SocketService socketService = SocketService();
  final secureStorage = const FlutterSecureStorage();

  @override
  void onInit() async {
    super.onInit();

    // Read token from secure storage.
    String? token = await secureStorage.read(key: Constants.accessToken);
    print("Token: $token");

    if (token == null || token.isEmpty) {
      print("Error: Access token is null or empty.");
      return;
    }

    // Initialize socket and connect.
    await _initializeSocket(token);

    // Once socket is connected, set up event listeners and fetch conversations.
    if (socketService.isConnected) {
      _setupSocketListeners();
      getConversations();
    } else {
      print('Error: Socket not connected.');
    }
  }

  Future<void> _initializeSocket(String token) async {
    // Initialize the socket connection. Await its initialization if needed.
    await socketService.initialize(token: token);
    if (socketService.isConnected) {
      print('Socket connected successfully.');
    } else {
      print('Error: Socket failed to connect.');
    }
  }

  void _setupSocketListeners() {
    // Listen for new messages (for the recipient).
    socketService.on('new-message', _handleNewMessage);

    // Listen for the conversations list response.
    socketService.on('conversations', (data) {
      print('conversations event: $data');
      try {
        var dataList = data is String ? jsonDecode(data) as List : data as List;
        conversations.value =
            dataList.map((e) => Conversation.fromJson(e)).toList();
      } catch (e) {
        print("Error parsing conversations: $e");
      }
      isLoading.value = false;
    });

    // Listen for a specific conversation's details (including messages).
    socketService.on('conversation', (data) {
      print('conversation event: $data');
      try {
        var decodedData = data is String ? jsonDecode(data) : data;
        // Assuming the structure is: { conversation: {...}, messages: [...] }
        if (decodedData['messages'] != null) {
          messages.value = (decodedData['messages'] as List)
              .map((e) => Message.fromJson(e))
              .toList();
        }
      } catch (e) {
        print("Error parsing conversation messages: $e");
      }
      isLoading.value = false;
    });

    // Optionally listen for the confirmation of a sent message.
    socketService.on('message-sent', (data) {
      print('message-sent event: $data');
      // You can update the UI if needed.
    });
  }

  @override
  void onClose() {
    // Remove all listeners to prevent memory leaks.
    socketService.off('new-message');
    socketService.off('conversations');
    socketService.off('conversation');
    socketService.off('message-sent');
    super.onClose();
  }

  /// Request conversations from the server.
  void getConversations() {
    if (socketService.isConnected) {
      isLoading.value = true;
      socketService.emit('get-conversations', {});
    } else {
      print("Error: Socket is not connected.");
    }
  }

  void getConversation(String conversationId) {
    if (socketService.isConnected) {
      socketService.emitWithAck(
        'get-conversation',
        {'conversationId': conversationId},
            (response) {
          print('get-conversation ack: $response');
          try {
            var data = response;
            messages.value = (data['messages'] as List)
                .map((e) => Message.fromJson(e))
                .toList();
          } catch (e) {
            print("Error parsing messages: $e");
          }
        },
      );
    } else {
      print("Error: Socket is not connected.");
    }
  }


  /// Send a message to the server.
  void sendMessage(String vegitableId, String sellerId, String messageText) {
    if (socketService.isConnected) {
      final messageData = {
        'vegitableId': vegitableId,
        'sellerId': sellerId,
        'message': messageText,
      };
      socketService.emit('send-message', messageData);
    } else {
      print("Error: Socket is not connected.");
    }
  }

  /// Socket event handler for incoming messages.
  void _handleNewMessage(dynamic data) {
    try {
      // The backend emits an object that may be encoded. Decode if necessary.
      final decodedData = data is String ? jsonDecode(data) : data;
      // If the payload wraps the message inside a field, adjust accordingly.
      final newMessage = Message.fromJson(decodedData['message'] ?? decodedData);
      messages.add(newMessage);
      update();
    } catch (e) {
      print("Error handling new message: $e");
    }
  }
}

