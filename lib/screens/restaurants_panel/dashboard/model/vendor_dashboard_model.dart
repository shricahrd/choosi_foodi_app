

import '../../../home/model/safe_convert.dart';

class VendorDashboardModel {
  final Meta? meta;
  final Data? data;

  VendorDashboardModel({
     this.meta,
     this.data,
  });

  factory VendorDashboardModel.fromJson(Map<String, dynamic>? json) => VendorDashboardModel(
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
  final int totalMenus;
  final int totalActiveMenus;
  final int totalDeactiveMenus;
  final int totalNewOrder;
  final int totalNewPickupOrder;
  final int totalNewDeliveryOrder;
  final int totalNewGroupOrder;
  final int totalNewGroupPickupOrder;
  final int totalNewGroupDeliveryOrder;
  final int totalOutOfDeliveryOrder;
  final int totalPickupOutOfDeliveryOrder;
  final int totalDeliveryOutOfDeliveryOrder;
  final int totalOutOfDeliveryGroupOrder;
  final int totalPickupOutOfDeliveryGroupOrder;
  final int totalDeliveryOutOfDeliveryGroupOrder;
  final int totalDeliveredOrder;
  final int totalDeliveredPickupOrder;
  final int totalDeliveredDeliveryOrder;
  final int totalDeliveredGroupOrder;
  final int totalDeliveredGroupPickupOrder;
  final int totalDeliveredGroupDeliveryOrder;
  final int totalCancelledOrder;
  final int totalCancelledPickupOrder;
  final int totalCancelledDeliveryOrder;
  final int totalCancelledGroupOrder;
  final int totalCancelledGroupPickupOrder;
  final int totalCancelledGroupDeliveryOrder;
  final double totalSale;
  final int totalGroupSale;
  final double totalComission;
  final int totalGroupComission;

  Data({
    this.totalMenus = 0,
    this.totalActiveMenus = 0,
    this.totalDeactiveMenus = 0,
    this.totalNewOrder = 0,
    this.totalNewPickupOrder = 0,
    this.totalNewDeliveryOrder = 0,
    this.totalNewGroupOrder = 0,
    this.totalNewGroupPickupOrder = 0,
    this.totalNewGroupDeliveryOrder = 0,
    this.totalOutOfDeliveryOrder = 0,
    this.totalPickupOutOfDeliveryOrder = 0,
    this.totalDeliveryOutOfDeliveryOrder = 0,
    this.totalOutOfDeliveryGroupOrder = 0,
    this.totalPickupOutOfDeliveryGroupOrder = 0,
    this.totalDeliveryOutOfDeliveryGroupOrder = 0,
    this.totalDeliveredOrder = 0,
    this.totalDeliveredPickupOrder = 0,
    this.totalDeliveredDeliveryOrder = 0,
    this.totalDeliveredGroupOrder = 0,
    this.totalDeliveredGroupPickupOrder = 0,
    this.totalDeliveredGroupDeliveryOrder = 0,
    this.totalCancelledOrder = 0,
    this.totalCancelledPickupOrder = 0,
    this.totalCancelledDeliveryOrder = 0,
    this.totalCancelledGroupOrder = 0,
    this.totalCancelledGroupPickupOrder = 0,
    this.totalCancelledGroupDeliveryOrder = 0,
    this.totalSale = 0.0,
    this.totalGroupSale = 0,
    this.totalComission = 0.0,
    this.totalGroupComission = 0,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    totalMenus: asT<int>(json, 'totalMenus'),
    totalActiveMenus: asT<int>(json, 'totalActiveMenus'),
    totalDeactiveMenus: asT<int>(json, 'totalDeactiveMenus'),
    totalNewOrder: asT<int>(json, 'totalNewOrder'),
    totalNewPickupOrder: asT<int>(json, 'totalNewPickupOrder'),
    totalNewDeliveryOrder: asT<int>(json, 'totalNewDeliveryOrder'),
    totalNewGroupOrder: asT<int>(json, 'totalNewGroupOrder'),
    totalNewGroupPickupOrder: asT<int>(json, 'totalNewGroupPickupOrder'),
    totalNewGroupDeliveryOrder: asT<int>(json, 'totalNewGroupDeliveryOrder'),
    totalOutOfDeliveryOrder: asT<int>(json, 'totalOutOfDeliveryOrder'),
    totalPickupOutOfDeliveryOrder: asT<int>(json, 'totalPickupOutOfDeliveryOrder'),
    totalDeliveryOutOfDeliveryOrder: asT<int>(json, 'totalDeliveryOutOfDeliveryOrder'),
    totalOutOfDeliveryGroupOrder: asT<int>(json, 'totalOutOfDeliveryGroupOrder'),
    totalPickupOutOfDeliveryGroupOrder: asT<int>(json, 'totalPickupOutOfDeliveryGroupOrder'),
    totalDeliveryOutOfDeliveryGroupOrder: asT<int>(json, 'totalDeliveryOutOfDeliveryGroupOrder'),
    totalDeliveredOrder: asT<int>(json, 'totalDeliveredOrder'),
    totalDeliveredPickupOrder: asT<int>(json, 'totalDeliveredPickupOrder'),
    totalDeliveredDeliveryOrder: asT<int>(json, 'totalDeliveredDeliveryOrder'),
    totalDeliveredGroupOrder: asT<int>(json, 'totalDeliveredGroupOrder'),
    totalDeliveredGroupPickupOrder: asT<int>(json, 'totalDeliveredGroupPickupOrder'),
    totalDeliveredGroupDeliveryOrder: asT<int>(json, 'totalDeliveredGroupDeliveryOrder'),
    totalCancelledOrder: asT<int>(json, 'totalCancelledOrder'),
    totalCancelledPickupOrder: asT<int>(json, 'totalCancelledPickupOrder'),
    totalCancelledDeliveryOrder: asT<int>(json, 'totalCancelledDeliveryOrder'),
    totalCancelledGroupOrder: asT<int>(json, 'totalCancelledGroupOrder'),
    totalCancelledGroupPickupOrder: asT<int>(json, 'totalCancelledGroupPickupOrder'),
    totalCancelledGroupDeliveryOrder: asT<int>(json, 'totalCancelledGroupDeliveryOrder'),
    totalSale: asT<double>(json, 'totalSale'),
    totalGroupSale: asT<int>(json, 'totalGroupSale'),
    totalComission: asT<double>(json, 'totalComission'),
    totalGroupComission: asT<int>(json, 'totalGroupComission'),
  );

  Map<String, dynamic> toJson() => {
    'totalMenus': totalMenus,
    'totalActiveMenus': totalActiveMenus,
    'totalDeactiveMenus': totalDeactiveMenus,
    'totalNewOrder': totalNewOrder,
    'totalNewPickupOrder': totalNewPickupOrder,
    'totalNewDeliveryOrder': totalNewDeliveryOrder,
    'totalNewGroupOrder': totalNewGroupOrder,
    'totalNewGroupPickupOrder': totalNewGroupPickupOrder,
    'totalNewGroupDeliveryOrder': totalNewGroupDeliveryOrder,
    'totalOutOfDeliveryOrder': totalOutOfDeliveryOrder,
    'totalPickupOutOfDeliveryOrder': totalPickupOutOfDeliveryOrder,
    'totalDeliveryOutOfDeliveryOrder': totalDeliveryOutOfDeliveryOrder,
    'totalOutOfDeliveryGroupOrder': totalOutOfDeliveryGroupOrder,
    'totalPickupOutOfDeliveryGroupOrder': totalPickupOutOfDeliveryGroupOrder,
    'totalDeliveryOutOfDeliveryGroupOrder': totalDeliveryOutOfDeliveryGroupOrder,
    'totalDeliveredOrder': totalDeliveredOrder,
    'totalDeliveredPickupOrder': totalDeliveredPickupOrder,
    'totalDeliveredDeliveryOrder': totalDeliveredDeliveryOrder,
    'totalDeliveredGroupOrder': totalDeliveredGroupOrder,
    'totalDeliveredGroupPickupOrder': totalDeliveredGroupPickupOrder,
    'totalDeliveredGroupDeliveryOrder': totalDeliveredGroupDeliveryOrder,
    'totalCancelledOrder': totalCancelledOrder,
    'totalCancelledPickupOrder': totalCancelledPickupOrder,
    'totalCancelledDeliveryOrder': totalCancelledDeliveryOrder,
    'totalCancelledGroupOrder': totalCancelledGroupOrder,
    'totalCancelledGroupPickupOrder': totalCancelledGroupPickupOrder,
    'totalCancelledGroupDeliveryOrder': totalCancelledGroupDeliveryOrder,
    'totalSale': totalSale,
    'totalGroupSale': totalGroupSale,
    'totalComission': totalComission,
    'totalGroupComission': totalGroupComission,
  };
}

