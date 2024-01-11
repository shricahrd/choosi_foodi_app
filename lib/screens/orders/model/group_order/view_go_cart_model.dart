

import 'package:choosifoodi/screens/orders/model/group_order/safe_convert.dart';

class ViewGoCartModel {
  final Meta? meta;
  final List<ViewGoCartData>? data;
  final dynamic total;
  final dynamic subTotal;

  ViewGoCartModel({
    this.meta,
    this.data,
    this.total,
    this.subTotal,
  });

  factory ViewGoCartModel.fromJson(Map<String, dynamic>? json) => ViewGoCartModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => ViewGoCartData.fromJson(e)).toList(),
    total: asT<String>(json, 'total'),
    subTotal: asT<String>(json, 'subTotal'),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((e) => e.toJson()),
    'total': total,
    'subTotal': subTotal,
  };
}

class Meta {
  final String? msg;
  final bool? status;

  Meta({
    this.msg,
    this.status,
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


class ViewGoCartData {
  final String? id;
  final String? groupCartId;
  final String? adminUserId;
  final String? adminUserName;
  final String? userId;
  final String? name;
  final String? groupId;
  final String? groupName;
  final String? restaurantId;
  final String? restaurantName;
  final List<CartMenuItem>? cartMenu;
  final int? createdAt;
  final int? updatedAt;
  bool? userDelete = false;
  final bool? isDelivery;

  ViewGoCartData({
    this.id = "",
    this.groupCartId = "",
    this.adminUserId = "",
    this.adminUserName = "",
    this.userId = "",
    this.name = "",
    this.groupId = "",
    this.groupName = "",
    this.restaurantId = "",
    this.restaurantName = "",
    required this.cartMenu,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.userDelete,
    this.isDelivery = false,
  });

  factory ViewGoCartData.fromJson(Map<String, dynamic>? json) => ViewGoCartData(
    id: asT<String>(json, '_id'),
    groupCartId: asT<String>(json, 'groupCartId'),
    adminUserId: asT<String>(json, 'adminUserId'),
    adminUserName: asT<String>(json, 'adminUserName'),
    userId: asT<String>(json, 'userId'),
    name: asT<String>(json, 'name'),
    groupId: asT<String>(json, 'groupId'),
    groupName: asT<String>(json, 'groupName'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantName: asT<String>(json, 'restaurantName'),
    cartMenu: asT<List>(json, 'cartMenu').map((e) => CartMenuItem.fromJson(e)).toList(),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    userDelete: asT<bool>(json, 'userDelete'),
    isDelivery: asT<bool>(json, 'isDelivery'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'groupCartId': groupCartId,
    'adminUserId': adminUserId,
    'adminUserName': adminUserName,
    'userId': userId,
    'name': name,
    'groupId': groupId,
    'groupName': groupName,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'isDelivery': isDelivery,
  };
}

class CartMenuItem {
  bool? itemDelete = false;
  final String? cartId;
  final String? id;
  final String? menuId;
  final int? selectQuantity;
  final String? dishName;
  final int? price;
  dynamic calclulatePrice = 0;

  CartMenuItem({
    this.cartId = "",
    this.id = "",
    this.menuId = "",
    this.selectQuantity = 0,
    this.dishName = "",
    this.price = 0,
    this.itemDelete,
    this.calclulatePrice,
  });

  factory CartMenuItem.fromJson(Map<String, dynamic>? json) => CartMenuItem(
    cartId: asT<String>(json, 'cartId'),
    id: asT<String>(json, '_id'),
    menuId: asT<String>(json, 'menuId'),
    selectQuantity: asT<int>(json, 'selectQuantity'),
    dishName: asT<String>(json, 'dishName'),
    price: asT<int>(json, 'price'),
    itemDelete: asT<bool>(json, 'itemDelete'),
  );

  set setPrice(dynamic value){
    this.calclulatePrice = value;
  }

  Map<String, dynamic> toJson() => {
    'cartId': cartId,
    '_id': id,
    'menuId': menuId,
    'selectQuantity': selectQuantity,
    'dishName': dishName,
    'price': price,
  };
}

