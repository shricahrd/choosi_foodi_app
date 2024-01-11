import '../../../home/model/safe_convert.dart';

class GetLedgerModel {
  final Meta? meta;
  final Data? data;

  GetLedgerModel({
     this.meta,
     this.data,
  });

  factory GetLedgerModel.fromJson(Map<String, dynamic>? json) => GetLedgerModel(
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
  final String ledgerId;
  final dynamic totalAmountEarned;
  final dynamic totalCommission;
  final dynamic netAmountEarned;
  final dynamic totalPaidAmount;
  final dynamic balanceAmount;
  final String id;
  final String restaurantId;
  final int createdAt;
  final int updatedAt;
  final int v;

  Data({
    this.ledgerId = "",
    this.totalAmountEarned = 0.0,
    this.totalCommission = 0.0,
    this.netAmountEarned = 0.0,
    this.totalPaidAmount = 0,
    this.balanceAmount = 0.0,
    this.id = "",
    this.restaurantId = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    ledgerId: asT<String>(json, 'ledgerId'),
    totalAmountEarned: asT<double>(json, 'totalAmountEarned'),
    totalCommission: asT<double>(json, 'totalCommission'),
    netAmountEarned: asT<double>(json, 'netAmountEarned'),
    totalPaidAmount: asT<int>(json, 'totalPaidAmount'),
    balanceAmount: asT<double>(json, 'balanceAmount'),
    id: asT<String>(json, '_id'),
    restaurantId: asT<String>(json, 'restaurantId'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'ledgerId': ledgerId,
    'totalAmountEarned': totalAmountEarned,
    'totalCommission': totalCommission,
    'netAmountEarned': netAmountEarned,
    'totalPaidAmount': totalPaidAmount,
    'balanceAmount': balanceAmount,
    '_id': id,
    'restaurantId': restaurantId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

