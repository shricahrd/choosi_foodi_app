import '../../../home/model/safe_convert.dart';

class CategoryListModel {
  final Meta? meta;
  final List<DataItem>? data;
  final int pages;
  final int total;

  CategoryListModel({
     this.meta,
     this.data,
    this.pages = 0,
    this.total = 0,
  });

  factory CategoryListModel.fromJson(Map<String, dynamic>? json) => CategoryListModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => DataItem.fromJson(e)).toList(),
    pages: asT<int>(json, 'pages'),
    total: asT<int>(json, 'total'),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((e) => e.toJson()).toList(),
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


class DataItem {
  final String categoryId;
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
  final String url;
  final int tax;
  bool isStatusUpdated;

  DataItem({
    this.categoryId = "",
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
    this.url = "",
    this.tax = 0,
    this.isStatusUpdated = false,
  });

  factory DataItem.fromJson(Map<String, dynamic>? json) => DataItem(
    categoryId: asT<String>(json, 'categoryId'),
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
    url: asT<String>(json, 'url'),
    tax: asT<int>(json, 'tax'),
    isStatusUpdated: asT<bool>(json, 'isStatusUpdated'),
  );

  set setStatusUpdated(bool isChecked){
    this.isStatusUpdated = isChecked;
    print("In Model _isStatusUpdated   $isStatusUpdated");
  }

  Map<String, dynamic> toJson() => {
    'categoryId': categoryId,
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
    'url': url,
    'tax': tax,
    'isStatusUpdated': isStatusUpdated,
  };
}

