class AllFavModel {
  bool? success;
  String? message;
  Data? data;

  AllFavModel({this.success, this.message, this.data});

  AllFavModel.fromJson(Map<String, dynamic> json) {
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
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  Location? location;
  String? sId;
  String? fullName;
  String? email;
  String? phone;
  String? password;
  String? avatar;
  List<FavouriteVegitables>? favouriteVegitables;
  List<String>? vegitablesToSell;
  String? createdAt;
  String? updatedAt;
  int? iV;

  User({
    this.location,
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
    this.iV,
  });

  User.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    fullName = json['fullName'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    avatar = json['avatar'];
    if (json['favouriteVegitables'] != null) {
      favouriteVegitables = (json['favouriteVegitables'] as List)
          .map((v) => FavouriteVegitables.fromJson(v))
          .toList();
    }
    vegitablesToSell = (json['vegitablesToSell'] as List?)?.cast<String>();
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
    if (favouriteVegitables != null) {
      data['favouriteVegitables'] = favouriteVegitables!.map((v) => v.toJson()).toList();
    }
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
    coordinates = (json['coordinates'] as List?)?.cast<double>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class FavouriteVegitables {
  Rating? rating;
  String? sId;
  String? name;
  String? vegitableImage;
  String? cost;
  String? description;

  FavouriteVegitables({
    this.rating,
    this.sId,
    this.name,
    this.vegitableImage,
    this.cost,
    this.description,
  });

  FavouriteVegitables.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    sId = json['_id'];
    name = json['name'];
    vegitableImage = json['vegitableImage'];
    cost = json['cost'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['vegitableImage'] = vegitableImage;
    data['cost'] = cost;
    data['description'] = description;
    return data;
  }
}

class Rating {
  int? average;
  int? count;

  Rating({this.average, this.count});

  Rating.fromJson(Map<String, dynamic> json) {
    average = json['average'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['average'] = average;
    data['count'] = count;
    return data;
  }
}
