import '../../home/model/safe_convert.dart';

class NotificationDetailsModel {
  final Meta? meta;
  final Data? data;

  NotificationDetailsModel({
     this.meta,
     this.data,
  });

  factory NotificationDetailsModel.fromJson(Map<String, dynamic>? json) => NotificationDetailsModel(
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
  final String notificationId;
  final String status;
  final bool isSentByAdmin;
  final String id;
  final String title;
  final String description;
  final String body;
  final int createdAt;
  final int updatedAt;
  final int v;

  Data({
    this.notificationId = "",
    this.status = "",
    this.isSentByAdmin = false,
    this.id = "",
    this.title = "",
    this.description = "",
    this.body = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    notificationId: asT<String>(json, 'notificationId'),
    status: asT<String>(json, 'status'),
    isSentByAdmin: asT<bool>(json, 'isSentByAdmin'),
    id: asT<String>(json, '_id'),
    title: asT<String>(json, 'title'),
    description: asT<String>(json, 'description'),
    body: asT<String>(json, 'body'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'notificationId': notificationId,
    'status': status,
    'isSentByAdmin': isSentByAdmin,
    '_id': id,
    'title': title,
    'description': description,
    'body': body,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

