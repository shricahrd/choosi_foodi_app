

import '../../orders/model/group_order/safe_convert.dart';

class FeaturedModel {
  final List<FeaturedFoodsItem> featuredFoods;

  FeaturedModel({
    required this.featuredFoods,
  });

  factory FeaturedModel.fromJson(Map<String, dynamic>? json) => FeaturedModel(
    featuredFoods: asT<List>(json, 'featuredFoods').map((e) => FeaturedFoodsItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'featuredFoods': featuredFoods.map((e) => e.toJson()).toList(),
  };
}

class FeaturedFoodsItem {
  final String menuId;
  final bool isVegetarian;
  final List<String> menuImg;
  final String restaurantId;
  final String dishName;
  final int createdAt;
  final int updatedAt;
  final String id;

  FeaturedFoodsItem({
    this.menuId = "",
    this.isVegetarian = false,
    required this.menuImg,
    this.restaurantId = "",
    this.dishName = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.id = "",
  });

  factory FeaturedFoodsItem.fromJson(Map<String, dynamic>? json) => FeaturedFoodsItem(
    menuId: asT<String>(json, 'menuId'),
    isVegetarian: asT<bool>(json, 'isVegetarian'),
    menuImg: asT<List>(json, 'menuImg').map((e) => e.toString()).toList(),
    restaurantId: asT<String>(json, 'restaurantId'),
    dishName: asT<String>(json, 'dishName'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    id: asT<String>(json, 'id'),
  );

  Map<String, dynamic> toJson() => {
    'menuId': menuId,
    'isVegetarian': isVegetarian,
    'menuImg': menuImg.map((e) => e).toList(),
    'restaurantId': restaurantId,
    'dishName': dishName,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'id': id,
  };
}

