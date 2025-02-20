// class CommonModel {
//   bool? success;
//   String? message;
//   final String? otp;
//   dynamic data;
//
//   CommonModel({this.success, this.message, this.data, this.otp});
//
//   CommonModel.fromJson(Map<String, dynamic> json) {
//     success = json['success'];
//     message = json['message'];
//     otp = json['otp'];
//     data = json['data'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['success'] = success;
//     data['message'] = message;
//     data['otp'] = otp;
//     data['data'] = this.data;
//     return data;
//   }
// }

class CommonModel {
  final bool? success;
  final String? message;
  final String? otp;
  final String? userId;
  final String? code;
  final String? verifyToken;
  final dynamic data;

  CommonModel({
    this.success,
    this.message,
    this.otp,
    this.userId,
    this.code,
    this.data,
    this.verifyToken
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
      success: json['success'] ?? false,
      message: json['message'],
      otp: json['otp'],
      code: json['code'],
      userId: json['userId'],
      data: json['data'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': success,
      'message': message,
      'userId' : userId,
      'code': code,
      'otp': otp,
      'user': data,
    };
  }
}
