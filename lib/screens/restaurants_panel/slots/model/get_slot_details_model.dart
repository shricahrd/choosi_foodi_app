import '../../../home/model/safe_convert.dart';

class GetSlotDetailsModel {
  final Meta? meta;
  final Data? data;

  GetSlotDetailsModel({
     this.meta,
     this.data,
  });

  factory GetSlotDetailsModel.fromJson(Map<String, dynamic>? json) => GetSlotDetailsModel(
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
  final String slotId;
  final String status;
  final String id;
  final String restaurantId;
  final String restaurantName;
  final String day;
  final List<TimeItem> time;
  final int createdAt;
  final int updatedAt;
  final int v;

  Data({
    this.slotId = "",
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.restaurantName = "",
    this.day = "",
    required this.time,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    slotId: asT<String>(json, 'slotId'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantName: asT<String>(json, 'restaurantName'),
    day: asT<String>(json, 'day'),
    time: asT<List>(json, 'time').map((e) => TimeItem.fromJson(e)).toList(),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'slotId': slotId,
    'status': status,
    '_id': id,
    'restaurantId': restaurantId,
    'restaurantName': restaurantName,
    'day': day,
    'time': time.map((e) => e.toJson()).toList(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class TimeItem {
  final String id;
  final String startTime;
  final String endTime;

  TimeItem({
    this.id = "",
    this.startTime = "",
    this.endTime = "",
  });

  factory TimeItem.fromJson(Map<String, dynamic>? json) => TimeItem(
    id: asT<String>(json, '_id'),
    startTime: asT<String>(json, 'startTime'),
    endTime: asT<String>(json, 'endTime'),
  );

  Map<String, dynamic> toJson() => {
    '_id': id,
    'startTime': startTime,
    'endTime': endTime,
  };
}

