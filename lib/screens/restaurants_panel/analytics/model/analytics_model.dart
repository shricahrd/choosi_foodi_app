import '../../../home/model/safe_convert.dart';

class AnalyticsModel {
  final Meta? meta;
  final List<AnalyticsDataList>? data;

  AnalyticsModel({
     this.meta,
     this.data,
  });

  factory AnalyticsModel.fromJson(Map<String, dynamic>? json) => AnalyticsModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => AnalyticsDataList.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((e) => e.toJson()).toList(),
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


class AnalyticsDataList {
  final String menuId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String foodOffered;
  final String state;
  final String status;
  final String id;
  final String restaurantId;
  final String dishName;
  final String description;
  final int price;
  final String foodType;
  final String dishType;
  final String dishVisibilityStart;
  final String dishVisibilityEnd;
  final int createdAt;
  final int updatedAt;
  final int v;
  final int calories;
  final int carbs;
  final int fat;
  final int protein;
  final int totalSale;

  AnalyticsDataList({
    this.menuId = "",
    this.isVegetarian = false,
    required this.menuImg,
    this.foodOffered = "",
    this.state = "",
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.dishName = "",
    this.description = "",
    this.price = 0,
    this.foodType = "",
    this.dishType = "",
    this.dishVisibilityStart = "",
    this.dishVisibilityEnd = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.calories = 0,
    this.carbs = 0,
    this.fat = 0,
    this.protein = 0,
    this.totalSale = 0,
  });

  factory AnalyticsDataList.fromJson(Map<String, dynamic>? json) => AnalyticsDataList(
    menuId: asT<String>(json, 'menuId'),
    isVegetarian: asT<bool>(json, 'isVegetarian'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    foodOffered: asT<String>(json, 'foodOffered'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    dishName: asT<String>(json, 'dishName'),
    description: asT<String>(json, 'description'),
    price: asT<int>(json, 'price'),
    foodType: asT<String>(json, 'foodType'),
    dishType: asT<String>(json, 'dishType'),
    dishVisibilityStart: asT<String>(json, 'dishVisibilityStart'),
    dishVisibilityEnd: asT<String>(json, 'dishVisibilityEnd'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    calories: asT<int>(json, 'calories'),
    carbs: asT<int>(json, 'carbs'),
    fat: asT<int>(json, 'fat'),
    protein: asT<int>(json, 'protein'),
    totalSale: asT<int>(json, 'totalSale'),
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
    'description': description,
    'price': price,
    'foodType': foodType,
    'dishType': dishType,
    'dishVisibilityStart': dishVisibilityStart,
    'dishVisibilityEnd': dishVisibilityEnd,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'calories': calories,
    'carbs': carbs,
    'fat': fat,
    'protein': protein,
    'totalSale': totalSale,
  };
}

