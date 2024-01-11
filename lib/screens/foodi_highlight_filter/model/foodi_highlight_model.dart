import '../../home/model/safe_convert.dart';

class FoodiHighlightModel {
  final Meta? meta;
  final Data? data;
  final int pages;
  final int total;

  FoodiHighlightModel({
     this.meta,
     this.data,
    this.pages = 0,
    this.total = 0,
  });

  factory FoodiHighlightModel.fromJson(Map<String, dynamic>? json) => FoodiHighlightModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: Data.fromJson(asT<Map<String, dynamic>>(json, 'data')),
    pages: asT<int>(json, 'pages'),
    total: asT<int>(json, 'total'),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.toJson(),
    'pages': pages,
    'total': total,
  };
}

class Meta {
  final String msg;
  final bool status;

  Meta({
    this.msg = "",
    this.status = false,
  });

  factory Meta.fromJson(Map<String, dynamic>? json) => Meta(
    msg: asT<String>(json, 'msg'),
    status: asT<bool>(json, 'status'),
  );

  Map<String, dynamic> toJson() => {
    'msg': msg,
    'status': status,
  };
}


class Data {
  final List<FoodiHighlightsItem> foodiHighlights;

  Data({
    required this.foodiHighlights,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    foodiHighlights: asT<List>(json, 'foodiHighlights').map((e) => FoodiHighlightsItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'foodiHighlights': foodiHighlights.map((e) => e.toJson()).toList(),
  };
}

class FoodiHighlightsItem {
  final String menuId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String foodOffered;
  final String state;
  final String status;
  final String id;
  final String restaurantId;
  final String dishName;
  final int price;
  final String foodType;
  final String dishType;
  final String dishVisibilityStart;
  final String dishVisibilityEnd;
  final int createdAt;
  final int updatedAt;
  bool isBuyNow;
  final Restaurant restaurant;

  FoodiHighlightsItem({
    this.menuId = "",
    this.isVegetarian = false,
    required this.menuImg,
    this.foodOffered = "",
    this.state = "",
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.dishName = "",
    this.price = 0,
    this.foodType = "",
    this.dishType = "",
    this.dishVisibilityStart = "",
    this.dishVisibilityEnd = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.isBuyNow = false,
    required this.restaurant,
  });


  set setBuyNow(bool? isChecked){
    this.isBuyNow = isChecked!;
    print("In Model isBuyNow   $isBuyNow");
  }

  factory FoodiHighlightsItem.fromJson(Map<String, dynamic>? json) => FoodiHighlightsItem(
    menuId: asT<String>(json, 'menuId'),
    isVegetarian: asT<bool>(json, 'isVegetarian'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    foodOffered: asT<String>(json, 'foodOffered'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    dishName: asT<String>(json, 'dishName'),
    price: asT<int>(json, 'price'),
    foodType: asT<String>(json, 'foodType'),
    dishType: asT<String>(json, 'dishType'),
    dishVisibilityStart: asT<String>(json, 'dishVisibilityStart'),
    dishVisibilityEnd: asT<String>(json, 'dishVisibilityEnd'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    isBuyNow: asT<bool>(json, 'isBuyNow'),
    restaurant: Restaurant.fromJson(asT<Map<String, dynamic>>(json, 'restaurant')),
  );

  Map<String, dynamic> toJson() => {
    'menuId': menuId,
    'isVegetarian': isVegetarian,
    'menuImg': menuImg.map((e) => e).toList(),
    'foodOffered': foodOffered,
    'state': state,
    'status': status,
    '_id': id,
    'restaurantId': restaurantId,
    'dishName': dishName,
    'price': price,
    'foodType': foodType,
    'dishType': dishType,
    'dishVisibilityStart': dishVisibilityStart,
    'dishVisibilityEnd': dishVisibilityEnd,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'isBuyNow': isBuyNow,
    'restaurant': restaurant.toJson(),
    'id': id,
  };
}

class Restaurant {
  final String restaurantId;
  final String id;
  final String restaurantName;

  Restaurant({
    this.restaurantId = "",
    this.id = "",
    this.restaurantName = "",
  });

  factory Restaurant.fromJson(Map<String, dynamic>? json) => Restaurant(
    restaurantId: asT<String>(json, 'restaurantId'),
    id: asT<String>(json, '_id'),
    restaurantName: asT<String>(json, 'restaurantName'),
  );

  Map<String, dynamic> toJson() => {
    'restaurantId': restaurantId,
    '_id': id,
    'restaurantName': restaurantName,
  };
}

