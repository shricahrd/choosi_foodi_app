

import '../../../home/model/safe_convert.dart';

class CategoryUpdateModel {
  final Meta? meta;
  final Data? data;

  CategoryUpdateModel({
     this.meta,
     this.data,
  });

  factory CategoryUpdateModel.fromJson(Map<String, dynamic>? json) => CategoryUpdateModel(
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
  final String categoryId;
  final String restaurantId;
  final int commission;
  final String status;
  final String type;
  final bool isCompare;
  final bool isFeaturedWeb;
  final bool isCategoryWebNav;
  final bool isCategoryMobile;
  final bool isCategoryMobileNav;
  final String id;
  final String categoryName;
  final String categoryImg;
  final int createdAt;
  final int updatedAt;
  final int v;

  Data({
    this.categoryId = "",
    this.restaurantId = "",
    this.commission = 0,
    this.status = "",
    this.type = "",
    this.isCompare = false,
    this.isFeaturedWeb = false,
    this.isCategoryWebNav = false,
    this.isCategoryMobile = false,
    this.isCategoryMobileNav = false,
    this.id = "",
    this.categoryName = "",
    this.categoryImg = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    categoryId: asT<String>(json, 'categoryId'),
    restaurantId: asT<String>(json, 'restaurantId'),
    commission: asT<int>(json, 'commission'),
    status: asT<String>(json, 'status'),
    type: asT<String>(json, 'type'),
    isCompare: asT<bool>(json, 'isCompare'),
    isFeaturedWeb: asT<bool>(json, 'isFeaturedWeb'),
    isCategoryWebNav: asT<bool>(json, 'isCategoryWebNav'),
    isCategoryMobile: asT<bool>(json, 'isCategoryMobile'),
    isCategoryMobileNav: asT<bool>(json, 'isCategoryMobileNav'),
    id: asT<String>(json, '_id'),
    categoryName: asT<String>(json, 'categoryName'),
    categoryImg: asT<String>(json, 'categoryImg'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
    'restaurantId': restaurantId,
    'commission': commission,
    'status': status,
    'type': type,
    'isCompare': isCompare,
    'isFeaturedWeb': isFeaturedWeb,
    'isCategoryWebNav': isCategoryWebNav,
    'isCategoryMobile': isCategoryMobile,
    'isCategoryMobileNav': isCategoryMobileNav,
    '_id': id,
    'categoryName': categoryName,
    'categoryImg': categoryImg,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

