

import '../../home/model/safe_convert.dart';

class GlobalSearchModel {
  final Meta? meta;
  final Data? data;

  GlobalSearchModel({
     this.meta,
     this.data,
  });

  factory GlobalSearchModel.fromJson(Map<String, dynamic>? json) => GlobalSearchModel(
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
  final List<RestaurantListItem>? restaurantList;
  final List<MenuListItem>? menuList;

  Data({
     this.restaurantList,
     this.menuList,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    restaurantList: asT<List>(json, 'restaurantList').map((e) => RestaurantListItem.fromJson(e)).toList(),
    menuList: asT<List>(json, 'menuList').map((e) => MenuListItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'restaurantList': restaurantList?.map((e) => e.toJson()),
    'menuList': menuList?.map((e) => e.toJson()),
  };
}

class RestaurantListItem {
  final String restaurantId;
  final String restaurantName;

  RestaurantListItem({
    this.restaurantId = "",
    this.restaurantName = "",
  });

  factory RestaurantListItem.fromJson(Map<String, dynamic>? json) => RestaurantListItem(
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantName: asT<String>(json, 'restaurantName'),
  );

  Map<String, dynamic> toJson() => {
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
  };
}


class MenuListItem {
  final String menuId;
  final String restaurantId;
  final String dishName;

  MenuListItem({
    this.menuId = "",
    this.restaurantId = "",
    this.dishName = "",
  });

  factory MenuListItem.fromJson(Map<String, dynamic>? json) => MenuListItem(
    menuId: asT<String>(json, 'menuId'),
    restaurantId: asT<String>(json, 'restaurantId'),
    dishName: asT<String>(json, 'dishName'),
  );

  Map<String, dynamic> toJson() => {
    'menuId': menuId,
    'restaurantId': restaurantId,
    'dishName': dishName,
  };
}

