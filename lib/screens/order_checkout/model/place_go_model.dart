

import '../../home/model/safe_convert.dart';

class PlaceGOModel {
  final Meta? meta;
  final Data? data;

  PlaceGOModel({
     this.meta,
     this.data,
  });

  factory PlaceGOModel.fromJson(Map<String, dynamic>? json) => PlaceGOModel(
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
  final String groupOrderId;

  Data({
    this.groupOrderId = "",
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    groupOrderId: asT<String>(json, 'groupOrderId'),
  );

  Map<String, dynamic> toJson() => {
    'groupOrderId': groupOrderId,
  };
}

