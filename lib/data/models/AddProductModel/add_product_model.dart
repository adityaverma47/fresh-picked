class AddProductModel {
  bool? success;
  String? message;
  Data? data;

  AddProductModel({this.success, this.message, this.data});

  AddProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  NewVegitable? newVegitable;

  Data({this.newVegitable});

  Data.fromJson(Map<String, dynamic> json) {
    newVegitable = json['newVegitable'] != null
        ? NewVegitable.fromJson(json['newVegitable'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (this.newVegitable != null) {
      data['newVegitable'] = this.newVegitable!.toJson();
    }
    return data;
  }
}

class NewVegitable {
  String? name;
  String? vegitableImage;
  String? cost;
  String? description;
  Rating? rating;
  Location? location;
  String? seller;
  bool? favourite;
  String? sId;
  String? createdAt;
  String? updatedAt;
  int? iV;

  NewVegitable(
      {this.name,
        this.vegitableImage,
        this.cost,
        this.description,
        this.rating,
        this.location,
        this.seller,
        this.favourite,
        this.sId,
        this.createdAt,
        this.updatedAt,
        this.iV});

  NewVegitable.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    vegitableImage = json['vegitableImage'];
    cost = json['cost'];
    description = json['description'];
    rating =
    json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    seller = json['seller'];
    favourite = json['favourite'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = this.name;
    data['vegitableImage'] = this.vegitableImage;
    data['cost'] = this.cost;
    data['description'] = this.description;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['seller'] = this.seller;
    data['favourite'] = this.favourite;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
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
    data['average'] = this.average;
    data['count'] = this.count;
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
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}
