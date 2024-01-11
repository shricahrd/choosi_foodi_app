import '../../../home/model/safe_convert.dart';

class GetCouponListModel {
  final Meta? meta;
  final List<CouponDataList>? data;

  GetCouponListModel({
     this.meta,
     this.data,
  });

  factory GetCouponListModel.fromJson(Map<String, dynamic>? json) => GetCouponListModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => CouponDataList.fromJson(e)).toList(),
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


class CouponDataList {
  final String couponId;
  final String type;
  final String couponType;
  final String couponFor;
  final String discountIn;
  final bool showInApp;
  final String status;
  final String id;
  final String restaurantId;
  final String couponName;
  final int discount;
  final int maxDiscount;
  final String description;
  final String couponImg;
  final int totalCoupon;
  final int minCartAmount;
  final int maxCartAmount;
  final int issueDate;
  final int expiryDate;
  final int createdAt;
  final int updatedAt;
  final int v;
  final int perUserUseCount;
  final int useCount;
  bool isStatusUpdated;

  CouponDataList({
    this.couponId = "",
    this.type = "",
    this.couponType = "",
    this.couponFor = "",
    this.discountIn = "",
    this.showInApp = false,
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.couponName = "",
    this.discount = 0,
    this.maxDiscount = 0,
    this.description = "",
    this.couponImg = "",
    this.totalCoupon = 0,
    this.minCartAmount = 0,
    this.maxCartAmount = 0,
    this.issueDate = 0,
    this.expiryDate = 0,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.perUserUseCount = 0,
    this.useCount = 0,
    this.isStatusUpdated = false,
  });

  set setStatusUpdated(bool isChecked){
    this.isStatusUpdated = isChecked;
    print("In Model isStatusUpdated   $isStatusUpdated");
  }


  factory CouponDataList.fromJson(Map<String, dynamic>? json) => CouponDataList(
    couponId: asT<String>(json, 'couponId'),
    type: asT<String>(json, 'type'),
    couponType: asT<String>(json, 'couponType'),
    couponFor: asT<String>(json, 'couponFor'),
    discountIn: asT<String>(json, 'discountIn'),
    showInApp: asT<bool>(json, 'showInApp'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    couponName: asT<String>(json, 'couponName'),
    discount: asT<int>(json, 'discount'),
    maxDiscount: asT<int>(json, 'maxDiscount'),
    description: asT<String>(json, 'description'),
    couponImg: asT<String>(json, 'couponImg'),
    totalCoupon: asT<int>(json, 'totalCoupon'),
    minCartAmount: asT<int>(json, 'minCartAmount'),
    maxCartAmount: asT<int>(json, 'maxCartAmount'),
    issueDate: asT<int>(json, 'issueDate'),
    expiryDate: asT<int>(json, 'expiryDate'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    perUserUseCount: asT<int>(json, 'perUserUseCount'),
    useCount: asT<int>(json, 'useCount'),
  );

  Map<String, dynamic> toJson() => {
    'couponId': couponId,
    'type': type,
    'couponType': couponType,
    'couponFor': couponFor,
    'discountIn': discountIn,
    'showInApp': showInApp,
    'status': status,
    '_id': id,
    'restaurantId': restaurantId,
    'couponName': couponName,
    'discount': discount,
    'maxDiscount': maxDiscount,
    'description': description,
    'couponImg': couponImg,
    'totalCoupon': totalCoupon,
    'minCartAmount': minCartAmount,
    'maxCartAmount': maxCartAmount,
    'issueDate': issueDate,
    'expiryDate': expiryDate,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'perUserUseCount': perUserUseCount,
    'useCount': useCount,
  };
}

