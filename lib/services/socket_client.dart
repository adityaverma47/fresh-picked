import 'dart:convert';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  // Singleton instance
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  IO.Socket? socket; // Nullable socket

  /// Initialize the socket connection.
  /// [token] is required for authentication.
  void initialize({required String token}) {
    if (socket != null) {
      print("Socket already initialized.");
      return;
    }

    socket = IO.io(
      'ws://localhost:5000', // Replace with your actual socket server URL
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // We'll connect manually
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    socket!.onConnect((_) {
      print('Socket connected');
    });

    socket!.onDisconnect((_) {
      print('Socket disconnected');
    });

    socket!.onError((error) {
      print('Socket error: $error');
    });

    socket!.onConnectError((error) {
      print('Socket connection error: $error');
    });

    // Connect after initialization
    socket!.connect();
  }

  /// Connect to the socket server.
  void connect() {
    if (socket == null) {
      print("Error: Socket is not initialized.");
      return;
    }
    if (socket!.connected) {
      print("Socket is already connected.");
      return;
    }
    socket!.connect();
  }

  /// Disconnect from the socket server.
  void disconnect() {
    if (socket == null) {
      print("Error: Socket is not initialized.");
      return;
    }
    socket!.disconnect();
    print("Socket disconnected.");
  }

  /// Emit a message event with acknowledgment.
  /// Ensures socket is connected before emitting.
  void emitWithAck(String event, Map<String, dynamic> data, Function(dynamic) ackCallback) {
    if (socket == null || !(socket!.connected)) {
      print("Error: Socket is not initialized or not connected.");
      return;
    }

    socket!.emitWithAck(event, jsonEncode(data), ack: (response) {
      ackCallback(response); // Call the provided callback with the response
    });
  }

  /// Listen for a specific event.
  void on(String event, Function(dynamic data) callback) {
    if (socket == null) {
      print("Error: Socket is not initialized.");
      return;
    }
    socket!.on(event, callback);
  }

  /// Remove a specific event listener.
  void off(String event) {
    if (socket == null) {
      print("Error: Socket is not initialized.");
      return;
    }
    socket!.off(event);
  }

  /// Check if the socket is connected
  bool get isConnected => socket?.connected ?? false;
}
