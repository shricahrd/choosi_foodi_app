

import '../../home/model/safe_convert.dart';

class GetQtyUpdateModel {
  final Meta? meta;

  GetQtyUpdateModel({
     this.meta,
  });

  factory GetQtyUpdateModel.fromJson(Map<String, dynamic>? json) => GetQtyUpdateModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
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

