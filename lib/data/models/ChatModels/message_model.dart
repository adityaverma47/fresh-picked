// message_model.dart
class Message {
  String? id;
  String? conversationId;
  String? sender;
  String? text;
  bool? readStatus;
  DateTime? createdAt;

  Message({
    this.id,
    this.conversationId,
    this.sender,
    this.text,
    this.readStatus,
    this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['_id'],
      conversationId: json['conversation'],
      sender: json['sender'],
      text: json['text'],
      readStatus: json['readStatus'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
    );
  }
}
