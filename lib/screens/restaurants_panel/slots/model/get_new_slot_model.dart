

import '../../../home/model/safe_convert.dart';

class GetNewSlotModel {
  final Meta? meta;
  final List<DataItem>? data;

  GetNewSlotModel({
     this.meta,
     this.data,
  });

  factory GetNewSlotModel.fromJson(Map<String, dynamic>? json) => GetNewSlotModel(
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
  final String slotId;
  final String status;
  final String id;
  final String restaurantId;
  final String day;
  final List<TimeItem> time;
  final int createdAt;
  final int updatedAt;
  final int v;
  bool isStatusUpdated;

  DataItem({
    this.slotId = "",
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.day = "",
    required this.time,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.isStatusUpdated = false,
  });

  factory DataItem.fromJson(Map<String, dynamic>? json) => DataItem(
    slotId: asT<String>(json, 'slotId'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    day: asT<String>(json, 'day'),
    time: asT<List>(json, 'time').map((e) => TimeItem.fromJson(e)).toList(),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  set setStatusUpdated(bool isChecked){
    this.isStatusUpdated = isChecked;
    // print("In Model isStatusUpdated   $isStatusUpdated");
  }

  Map<String, dynamic> toJson() => {
    'slotId': slotId,
    'status': status,
    '_id': id,
    'restaurantId': restaurantId,
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
  late String combineTime;

  TimeItem({
    this.id = "",
    this.startTime = "",
    this.endTime = "",
    this.combineTime = "",
  });

  set setTimeUpdated(String data){
    this.combineTime = data;
  }


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

