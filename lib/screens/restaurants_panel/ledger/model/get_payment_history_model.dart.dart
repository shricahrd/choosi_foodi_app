import '../../../home/model/safe_convert.dart';

class GetPaymentHistoryModel {
  final Meta? meta;
  final List<PaymentDataList>? data;

  GetPaymentHistoryModel({
     this.meta,
     this.data,
  });

  factory GetPaymentHistoryModel.fromJson(Map<String, dynamic>? json) => GetPaymentHistoryModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: asT<List>(json, 'data').map((e) => PaymentDataList.fromJson(e)).toList(),
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


class PaymentDataList {
  final String paymentId;
  // final double totalAmountAvailable;
  final dynamic paidAmount;
  final double balanceAmount;
  final String paymentMode;
  final String transactionId;
  final String id;
  final String ledgerId;
  final String restaurantId;
  final RestaurantData restaurantData;
  final int createdAt;
  final int updatedAt;
  final int v;

  PaymentDataList({
    this.paymentId = "",
    // this.totalAmountAvailable = 0.0,
    this.paidAmount = 0,
    this.balanceAmount = 0.0,
    this.paymentMode = "",
    this.transactionId = "",
    this.id = "",
    this.ledgerId = "",
    this.restaurantId = "",
    required this.restaurantData,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
  });

  factory PaymentDataList.fromJson(Map<String, dynamic>? json) => PaymentDataList(
    paymentId: asT<String>(json, 'paymentId'),
    // totalAmountAvailable: asT<double>(json, 'totalAmountAvailable'),
    paidAmount: asT<int>(json, 'paidAmount'),
    balanceAmount: asT<double>(json, 'balanceAmount'),
    paymentMode: asT<String>(json, 'paymentMode'),
    transactionId: asT<String>(json, 'transactionId'),
    id: asT<String>(json, '_id'),
    ledgerId: asT<String>(json, 'ledgerId'),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantData: RestaurantData.fromJson(asT<Map<String, dynamic>>(json, 'restaurantData')),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'paymentId': paymentId,
    // 'totalAmountAvailable': totalAmountAvailable,
    'paidAmount': paidAmount,
    'balanceAmount': balanceAmount,
    'paymentMode': paymentMode,
    'transactionId': transactionId,
    '_id': id,
    'ledgerId': ledgerId,
    'restaurantId': restaurantId,
    'restaurantData': restaurantData.toJson(),
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
  };
}

class RestaurantData {
  final BankInformation bankInformation;

  RestaurantData({
    required this.bankInformation,
  });

  factory RestaurantData.fromJson(Map<String, dynamic>? json) => RestaurantData(
    bankInformation: BankInformation.fromJson(asT<Map<String, dynamic>>(json, 'bankInformation')),
  );

  Map<String, dynamic> toJson() => {
    'bankInformation': bankInformation.toJson(),
  };
}

class BankInformation {
  final String bankName;
  final String accountNumber;
  final String routingNumber;

  BankInformation({
    this.bankName = "",
    this.accountNumber = "",
    this.routingNumber = "",
  });

  factory BankInformation.fromJson(Map<String, dynamic>? json) => BankInformation(
    bankName: asT<String>(json, 'bankName'),
    accountNumber: asT<String>(json, 'accountNumber'),
    routingNumber: asT<String>(json, 'routingNumber'),
  );

  Map<String, dynamic> toJson() => {
    'bankName': bankName,
    'accountNumber': accountNumber,
    'routingNumber': routingNumber,
  };
}

