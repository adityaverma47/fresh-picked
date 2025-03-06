class AddToFavModel {
  bool? success;
  String? message;
  Data? data;

  AddToFavModel({this.success, this.message, this.data});

  AddToFavModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  UpdatedUser? updatedUser;

  Data({this.updatedUser});

  Data.fromJson(Map<String, dynamic> json) {
    updatedUser = json['updatedUser'] != null
        ? UpdatedUser.fromJson(json['updatedUser'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (updatedUser != null) {
      data['updatedUser'] = updatedUser!.toJson();
    }
    return data;
  }
}

class UpdatedUser {
  Location? location;
  String? sId;
  String? fullName;
  String? email;
  String? phone;
  String? password;
  String? avatar;
  List<String>? favouriteVegitables;
  List<String>? vegitablesToSell;
  String? createdAt;
  String? updatedAt;
  int? iV;

  UpdatedUser(
      {this.location,
        this.sId,
        this.fullName,
        this.email,
        this.phone,
        this.password,
        this.avatar,
        this.favouriteVegitables,
        this.vegitablesToSell,
        this.createdAt,
        this.updatedAt,
        this.iV});

  UpdatedUser.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    avatar = json['avatar'];
    favouriteVegitables = json['favouriteVegitables']?.cast<String>();
    vegitablesToSell = json['vegitablesToSell']?.cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['fullName'] = fullName;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['avatar'] = avatar;
    data['favouriteVegitables'] = favouriteVegitables;
    data['vegitablesToSell'] = vegitablesToSell;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class Location {
  String? type;
  List<double>? coordinates;

  Location({this.type, this.coordinates});

  Location.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    coordinates = json['coordinates']?.cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}
