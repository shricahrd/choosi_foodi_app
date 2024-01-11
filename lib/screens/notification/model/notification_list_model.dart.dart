

import '../../home/model/safe_convert.dart';

class NotificationModel {
  final Meta? meta;
  final List<DataItem>? data;
  final int totalRead;
  final int totalUnread;

  NotificationModel({
     this.meta,
     this.data,
    this.totalRead = 0,
    this.totalUnread = 0,
  });

  factory NotificationModel.fromJson(Map<String, dynamic>? json) => NotificationModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => DataItem.fromJson(e)).toList(),
    totalRead: asT<int>(json, 'totalRead'),
    totalUnread: asT<int>(json, 'totalUnread'),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((e) => e.toJson()),
    'totalRead': totalRead,
    'totalUnread': totalUnread,
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
  final String notificationId;
  final String status;
  final String id;
  final String userId;
  final String userName;
  final String groupId;
  final String title;
  final String body;
  final String url;
  final String notificationType;
  final int createdAt;
  final int updatedAt;
  final int v;
  final String response;

  DataItem({
    this.notificationId = "",
    this.status = "",
    this.id = "",
    this.userId = "",
    this.userName = "",
    this.groupId = "",
    this.title = "",
    this.body = "",
    this.url = "",
    this.notificationType = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.response = "",
  });

  factory DataItem.fromJson(Map<String, dynamic>? json) => DataItem(
    notificationId: asT<String>(json, 'notificationId'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    userId: asT<String>(json, 'userId'),
    userName: asT<String>(json, 'userName'),
    groupId: asT<String>(json, 'groupId'),
    title: asT<String>(json, 'title'),
    body: asT<String>(json, 'body'),
    url: asT<String>(json, 'url'),
    notificationType: asT<String>(json, 'notificationType'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    response: asT<String>(json, 'response'),
  );

  Map<String, dynamic> toJson() => {
    'notificationId': notificationId,
    'status': status,
    '_id': id,
    'userId': userId,
    'userName': userName,
    'groupId': groupId,
    'title': title,
    'body': body,
    'url': url,
    'notificationType': notificationType,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'response': response,
  };
}

