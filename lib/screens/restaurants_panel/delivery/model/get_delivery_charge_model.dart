import '../../../home/model/safe_convert.dart';

class GetDeliveryChargeModel {
  final Meta? meta;
  final Data? data;

  GetDeliveryChargeModel({
     this.meta,
     this.data,
  });

  factory GetDeliveryChargeModel.fromJson(Map<String, dynamic>? json) => GetDeliveryChargeModel(
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
  final int deliveryCharges;
  final int minimumOrderValue;
  final String id;

  Data({
    this.deliveryCharges = 0,
    this.minimumOrderValue = 0,
    this.id = "",
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    minimumOrderValue: asT<int>(json, 'minimumOrderValue'),
    id: asT<String>(json, '_id'),
  );

  Map<String, dynamic> toJson() => {
    'deliveryCharges': deliveryCharges,
    'minimumOrderValue': minimumOrderValue,
    '_id': id,
  };
}

