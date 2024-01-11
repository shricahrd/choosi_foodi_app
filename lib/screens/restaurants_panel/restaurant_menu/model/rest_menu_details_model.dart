import '../../../home/model/safe_convert.dart';

class RestMenuDetailsModel {
  final Meta? meta;
  final Data? data;

  RestMenuDetailsModel({
     this.meta,
     this.data,
  });

  factory RestMenuDetailsModel.fromJson(Map<String, dynamic>? json) => RestMenuDetailsModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: Data.fromJson(asT<Map<String, dynamic>>(json, 'data')),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.toJson(),
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
  final String menuId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String foodOffered;
  final List<dynamic> tree;
  final List<dynamic> dishTypeIds;
  final String state;
  final String status;
  final String id;
  final String restaurantId;
  final String dishName;
  final String description;
  final int price;
  late String foodType;
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
  final List<OtherAddonsItem>? otherAddons;
  final List<dynamic>? rootCatgory;
  final List<dynamic>? catgory;

  Data({
    this.menuId = "",
    this.isVegetarian = false,
    required this.menuImg,
    this.foodOffered = "",
    required this.tree,
    required this.dishTypeIds,
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
     this.otherAddons,
     this.rootCatgory,
     this.catgory,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    menuId: asT<String>(json, 'menuId'),
    isVegetarian: asT<bool>(json, 'isVegetarian'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    foodOffered: asT<String>(json, 'foodOffered'),
    tree: asT<List>(json, 'tree').map((e) => e.toString()).toList(),
    dishTypeIds: asT<List>(json, 'dishTypeIds').map((e) => e.toString()).toList(),
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
    otherAddons: asT<List>(json, 'otherAddons').map((e) => OtherAddonsItem.fromJson(e)).toList(),
    rootCatgory: asT<List>(json, 'rootCatgory').map((e) => e.toString()).toList(),
    catgory: asT<List>(json, 'catgory').map((e) => e.toString()).toList(),
  );

  set setFoodType(String foodtype){
    this.foodType = foodtype;
  }

  Map<String, dynamic> toJson() => {
    'menuId': menuId,
    'isVegetarian': isVegetarian,
    'menuImg': menuImg.map((e) => e).toList(),
    'foodOffered': foodOffered,
    'tree': tree.map((e) => e).toList(),
    'dishTypeIds': dishTypeIds.map((e) => e).toList(),
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
    'otherAddons': otherAddons?.map((e) => e.toJson()).toList(),
    'rootCatgory': rootCatgory?.map((e) => e).toList(),
    'catgory': catgory?.map((e) => e).toList(),
  };
}

class OtherAddonsItem {
  final String id;
  final String title;
  final List<OptionsItem> options;

  OtherAddonsItem({
    this.id = "",
    this.title = "",
    required this.options,
  });

  factory OtherAddonsItem.fromJson(Map<String, dynamic>? json) => OtherAddonsItem(
    id: asT<String>(json, '_id'),
    title: asT<String>(json, 'title'),
    options: asT<List>(json, 'options').map((e) => OptionsItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'title': title,
    'options': options.map((e) => e.toJson()).toList(),
  };
}

class OptionsItem {
  final String id;
  final String option;

  OptionsItem({
    this.id = "",
    this.option = "",
  });

  factory OptionsItem.fromJson(Map<String, dynamic>? json) => OptionsItem(
    id: asT<String>(json, '_id'),
    option: asT<String>(json, 'option'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'option': option,
  };
}

