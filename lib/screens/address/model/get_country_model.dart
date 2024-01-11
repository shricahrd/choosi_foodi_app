import '../../home/model/safe_convert.dart';

class GetCountryModel {
  final Meta? meta;
  final List<DataItem>? data;

  GetCountryModel({
     this.meta,
     this.data,
  });

  factory GetCountryModel.fromJson(Map<String, dynamic>? json) => GetCountryModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => DataItem.fromJson(e)).toList(),
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


class DataItem {
  final String countryId;
  final String status;
  final String id;
  final String countryName;
  final String shortName;
  final String countryCode;
  final int createdAt;
  final int updatedAt;
  final int v;

  DataItem({
    this.countryId = "",
    this.status = "",
    this.id = "",
    this.countryName = "",
    this.shortName = "",
    this.countryCode = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory DataItem.fromJson(Map<String, dynamic>? json) => DataItem(
    countryId: asT<String>(json, 'countryId'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    countryName: asT<String>(json, 'countryName'),
    shortName: asT<String>(json, 'shortName'),
    countryCode: asT<String>(json, 'countryCode'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'countryId': countryId,
    'status': status,
    '_id': id,
    'countryName': countryName,
    'shortName': shortName,
    'countryCode': countryCode,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

