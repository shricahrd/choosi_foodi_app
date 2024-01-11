import '../../home/model/safe_convert.dart';

class AboutUsModel {
  final Meta? meta;
  final Data? data;

  AboutUsModel({
     this.meta,
     this.data,
  });

  factory AboutUsModel.fromJson(Map<String, dynamic>? json) => AboutUsModel(
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
  final String pageId;
  final String status;
  final String id;
  final String title;
  final dynamic url;
  final String description;
  final int createdAt;
  final int updatedAt;
  final int v;

  Data({
    this.pageId = "",
    this.status = "",
    this.id = "",
    this.title = "",
    this.url,
    this.description = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    pageId: asT<String>(json, 'pageId'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    title: asT<String>(json, 'title'),
    url: asT<dynamic>(json, 'url'),
    description: asT<String>(json, 'description'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'pageId': pageId,
    'status': status,
    '_id': id,
    'title': title,
    'url': url,
    'description': description,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

