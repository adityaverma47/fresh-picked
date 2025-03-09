class HomeProductModel {
  bool? success;
  Data? data;
  String? message;

  HomeProductModel({this.success, this.data, this.message});

  HomeProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data {
  List<FivekMRangeProducts>? fivekMRangeProducts;

  Data({this.fivekMRangeProducts});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['FivekMRangeProducts'] != null) {
      fivekMRangeProducts = [];
      json['FivekMRangeProducts'].forEach((v) {
        fivekMRangeProducts!.add(FivekMRangeProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (fivekMRangeProducts != null) {
      data['FivekMRangeProducts'] =
          fivekMRangeProducts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FivekMRangeProducts {
  Rating? rating;
  Location? location;
  String? sId;
  String? name;
  String? vegitableImage;
  String? cost;
  String? description;
  Seller? seller;
  String? createdAt;
  String? updatedAt;
  int? iV;
  double? distance; // Changed from int? to double?

  FivekMRangeProducts(
      {this.rating,
        this.location,
        this.sId,
        this.name,
        this.vegitableImage,
        this.cost,
        this.description,
        this.seller,
        this.createdAt,
        this.updatedAt,
        this.iV,
        this.distance});

  FivekMRangeProducts.fromJson(Map<String, dynamic> json) {
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    name = json['name'];
    vegitableImage = json['vegitableImage'];
    cost = json['cost'];
    description = json['description'];
    seller = json['seller'] != null ? Seller.fromJson(json['seller']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    // Convert the distance value (whether int or double) to double
    distance = (json['distance'] as num?)?.toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    if (seller != null) {
      data['seller'] = seller!.toJson();
    }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['distance'] = distance;
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['coordinates'] = coordinates;
    return data;
  }
}

class Seller {
  Location? location;
  String? sId;
  String? email;
  String? phone;
  String? avatar;
  String? address;

  Seller(
      {this.location, this.sId, this.email, this.phone, this.avatar, this.address});

  Seller.fromJson(Map<String, dynamic> json) {
    location =
    json['location'] != null ? Location.fromJson(json['location']) : null;
    sId = json['_id'];
    email = json['email'];
    phone = json['phone'];
    avatar = json['avatar'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['email'] = email;
    data['phone'] = phone;
    data['avatar'] = avatar;
    data['address'] = address;
    return data;
  }
}
