import '../../../home/model/safe_convert.dart';

class GetCommissionModel {
  final Meta? meta;
  final Data? data;

  GetCommissionModel({
     this.meta,
     this.data,
  });

  factory GetCommissionModel.fromJson(Map<String, dynamic>? json) => GetCommissionModel(
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
  final int commission;

  Data({
    this.commission = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    commission: asT<int>(json, 'commission'),
  );

  Map<String, dynamic> toJson() => {
    'commission': commission,
  };
}

