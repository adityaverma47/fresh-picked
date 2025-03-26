import 'dart:convert';
import 'package:fresh_picked/core/app_export.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SocketService {
  // Singleton instance
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();
  final secureStorage = const FlutterSecureStorage();

  IO.Socket? socket;

  /// Initialize the socket connection.
  /// [token] is required for authentication.
  Future<void> initialize({required String token}) async {
    // Check if socket already exists
    if (socket != null) {
      print("Socket already initialized.");
      return;
    }

    // Use the appropriate URL.
    // For Android emulator, replace 'localhost' with '10.0.2.2'
    const String serverUrl = 'https://lbhkfnz4-5000.inc1.devtunnels.ms/'; // Change if needed

    socket = IO.io(
      serverUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect() // We'll connect manually
          .setExtraHeaders({'Authorization': 'Bearer $token'})
          .build(),
    );

    print("Token: $token");

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

    // Wait briefly to allow connection attempt (optional)
    await Future.delayed(Duration(seconds: 2));
  }

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

  void disconnect() {
    if (socket == null) {
      print("Error: Socket is not initialized.");
      return;
    }
    socket!.disconnect();
    print("Socket disconnected.");
  }

  void emit(String event, Map<String, dynamic> data) {
    if (socket == null || !(socket!.connected)) {
      print("Error: Socket is not initialized or not connected.");
      return;
    }
    socket!.emit(event, jsonEncode(data));
  }

  void emitWithAck(String event, Map<String, dynamic> data, Function(dynamic) ackCallback) {
    if (socket == null || !(socket!.connected)) {
      print("Error: Socket is not initialized or not connected.");
      return;
    }
    socket!.emitWithAck(event, jsonEncode(data), ack: (response) {
      ackCallback(response);
    });
  }

  void on(String event, Function(dynamic data) callback) {
    if (socket == null) {
      print("Error: Socket is not initialized.");
      return;
    }
    socket!.on(event, callback);
  }

  void off(String event) {
    if (socket == null) {
      print("Error: Socket is not initialized.");
      return;
    }
    socket!.off(event);
  }

  bool get isConnected => socket?.connected ?? false;
}
