import '../../home/model/safe_convert.dart';

class GetSlotTypeModel {
  final Meta? meta;
  final List<DataItem>? data;

  GetSlotTypeModel({
     this.meta,
     this.data,
  });

  factory GetSlotTypeModel.fromJson(Map<String, dynamic>? json) => GetSlotTypeModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => DataItem.fromJson(e)).toList(),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.map((e) => e.toJson()),
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
  final String restaurantName;
  final String startTime;
  final String endTime;
  late String combineTime;
  late bool isAvail;
  final int createdAt;
  final int updatedAt;
  final int v;

  DataItem({
    this.slotId = "",
    this.status = "",
    this.id = "",
    this.restaurantId = "",
    this.restaurantName = "",
    this.startTime = "",
    this.endTime = "",
    this.combineTime = "",
    this.isAvail = false,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  set setCombineTime(String val){
    this.combineTime = val;
  }

  set setAvailTime(bool val){
    this.isAvail = val;
  }

  factory DataItem.fromJson(Map<String, dynamic>? json) => DataItem(
    slotId: asT<String>(json, 'slotId'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantName: asT<String>(json, 'restaurantName'),
    startTime: asT<String>(json, 'startTime'),
    endTime: asT<String>(json, 'endTime'),
    combineTime: asT<String>(json, 'combineTime'),
    isAvail: asT<bool>(json, 'isAvail'),
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
    'startTime': startTime,
    'endTime': endTime,
    'isAvail': isAvail,
    'combineTime': combineTime,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

