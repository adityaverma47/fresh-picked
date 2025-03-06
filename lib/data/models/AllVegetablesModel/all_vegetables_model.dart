class AllVegetablesModel {
  bool? success;
  String? message;
  Data? data;

  AllVegetablesModel({this.success, this.message, this.data});

  AllVegetablesModel.fromJson(Map<String, dynamic> json) {
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
  List<Vegitables>? vegitables;

  Data({this.vegitables});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['vegitables'] != null) {
      vegitables = [];
      json['vegitables'].forEach((v) {
        vegitables!.add(Vegitables.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (vegitables != null) {
      data['vegitables'] = vegitables!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vegitables {
  Rating? rating;
  Location? location;
  String? sId;
  String? name;
  String? vegitableImage;
  String? cost;
  String? description;
  String? seller;
  bool? favourite;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Vegitables({
    this.rating,
    this.location,
    this.sId,
    this.name,
    this.vegitableImage,
    this.cost,
    this.description,
    this.seller,
    this.favourite,
    this.createdAt,
    this.updatedAt,
    this.iV,
  });

  Vegitables.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    location = json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    vegitableImage = json['vegitableImage'];
    cost = json['cost'];
    description = json['description'];
    seller = json['seller'];
    favourite = json['favourite'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (rating != null) {
      data['rating'] = rating!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['name'] = name;
    data['vegitableImage'] = vegitableImage;
    data['cost'] = cost;
    data['description'] = description;
    data['seller'] = seller;
    data['favourite'] = favourite;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
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
