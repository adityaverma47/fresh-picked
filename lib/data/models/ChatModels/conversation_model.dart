// conversation_model.dart

class Conversation {
  String? id;
  Vegitable? vegitable;
  ConversationUser? buyer;
  ConversationUser? seller;

  Conversation({
    this.id,
    this.vegitable,
    this.buyer,
    this.seller,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      vegitable:
      json['vegitable'] != null ? Vegitable.fromJson(json['vegitable']) : null,
      buyer: json['buyer'] != null ? ConversationUser.fromJson(json['buyer']) : null,
      seller: json['seller'] != null ? ConversationUser.fromJson(json['seller']) : null,
    );
  }
}

class Vegitable {
  String? name;
  String? vegitableImage;
  double? cost;

  Vegitable({this.name, this.vegitableImage, this.cost});

  factory Vegitable.fromJson(Map<String, dynamic> json) {
    return Vegitable(
      name: json['name'],
      vegitableImage: json['vegitableImage'],
      cost: (json['cost'] as num).toDouble(),
    );
  }
}

/// A separate User model tailored for chat and conversation purposes.
/// This is independent from your Login model's User if you want to keep them separate.
class ConversationUser {
  String? id;
  String? fullName;
  String? email;
  String? phone;
  String? avatar;

  ConversationUser({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.avatar,
  });

  factory ConversationUser.fromJson(Map<String, dynamic> json) {
    return ConversationUser(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      avatar: json['avatar'],
    );
  }
}
