

import '../../home/model/safe_convert.dart';

class PlaceOrderModel {
  final Meta? meta;
  final Data? data;

  PlaceOrderModel({
     this.meta,
     this.data,
  });

  factory PlaceOrderModel.fromJson(Map<String, dynamic>? json) => PlaceOrderModel(
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
  final String menuOrderId;

  Data({
    this.menuOrderId = "",
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    menuOrderId: asT<String>(json, 'menuOrderId'),
  );

  Map<String, dynamic> toJson() => {
    'menuOrderId': menuOrderId,
  };
}

