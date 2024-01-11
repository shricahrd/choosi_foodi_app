

import '../../../home/model/safe_convert.dart';

class AddRestaurantModel {
  final Meta? meta;
  final Data? data;

  AddRestaurantModel({
     this.meta,
     this.data,
  });

  factory AddRestaurantModel.fromJson(Map<String, dynamic>? json) => AddRestaurantModel(
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
  final BankInformation bankInformation;
  final String restaurantId;
  final List<String> restaurantImg;
  final List<dynamic> restaurantDocument;
  final bool otpVerified;
  final bool isLogin;
  final bool isAddedByAdmin;
  final bool isSignupComplete;
  final bool isProfileComplete;
  final int deliveryTime;
  final bool isPickup;
  final bool isDelivery;
  final double ratings;
  final int deliveryCharges;
  final String state;
  final String status;
  final String id;
  final String vendorId;
  final int mobile;
  final String vendorName;
  final String email;
  final int createdAt;
  final int updatedAt;
  final int v;
  final List<dynamic> coordinates;
  final String managerMobile;
  final String managerName;
  final String restaurantAddress;
  final String restaurantName;

  Data({
    required this.bankInformation,
    this.restaurantId = "",
    required this.restaurantImg,
    required this.restaurantDocument,
    this.otpVerified = false,
    this.isLogin = false,
    this.isAddedByAdmin = false,
    this.isSignupComplete = false,
    this.isProfileComplete = false,
    this.deliveryTime = 0,
    this.isPickup = false,
    this.isDelivery = false,
    this.ratings = 0.0,
    this.deliveryCharges = 0,
    this.state = "",
    this.status = "",
    this.id = "",
    this.vendorId = "",
    this.mobile = 0,
    this.vendorName = "",
    this.email = "",
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    required this.coordinates,
    this.managerMobile = "",
    this.managerName = "",
    this.restaurantAddress = "",
    this.restaurantName = "",
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    bankInformation: BankInformation.fromJson(asT<Map<String, dynamic>>(json, 'bankInformation')),
    restaurantId: asT<String>(json, 'restaurantId'),
    restaurantImg: asT<List>(json, 'restaurantImg').map((e) => e.toString()).toList(),
    restaurantDocument: asT<List>(json, 'restaurantDocument').map((e) => e.toString()).toList(),
    otpVerified: asT<bool>(json, 'otpVerified'),
    isLogin: asT<bool>(json, 'isLogin'),
    isAddedByAdmin: asT<bool>(json, 'isAddedByAdmin'),
    isSignupComplete: asT<bool>(json, 'isSignupComplete'),
    isProfileComplete: asT<bool>(json, 'isProfileComplete'),
    deliveryTime: asT<int>(json, 'deliveryTime'),
    isPickup: asT<bool>(json, 'isPickup'),
    isDelivery: asT<bool>(json, 'isDelivery'),
    ratings: asT<double>(json, 'ratings'),
    deliveryCharges: asT<int>(json, 'deliveryCharges'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    vendorId: asT<String>(json, 'vendorId'),
    mobile: asT<int>(json, 'mobile'),
    vendorName: asT<String>(json, 'vendorName'),
    email: asT<String>(json, 'email'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    coordinates: asT<List>(json, 'coordinates').map((e) => double.tryParse(e.toString()) ?? 0.0).toList(),
    managerMobile: asT<String>(json, 'managerMobile'),
    managerName: asT<String>(json, 'managerName'),
    restaurantAddress: asT<String>(json, 'restaurantAddress'),
    restaurantName: asT<String>(json, 'restaurantName'),
  );

  Map<String, dynamic> toJson() => {
    'bankInformation': bankInformation.toJson(),
    'restaurantId': restaurantId,
    'restaurantImg': restaurantImg.map((e) => e).toList(),
    'restaurantDocument': restaurantDocument.map((e) => e).toList(),
    'otpVerified': otpVerified,
    'isLogin': isLogin,
    'isAddedByAdmin': isAddedByAdmin,
    'isSignupComplete': isSignupComplete,
    'isProfileComplete': isProfileComplete,
    'deliveryTime': deliveryTime,
    'isPickup': isPickup,
    'isDelivery': isDelivery,
    'ratings': ratings,
    'deliveryCharges': deliveryCharges,
    'state': state,
    'status': status,
    '_id': id,
    'vendorId': vendorId,
    'mobile': mobile,
    'vendorName': vendorName,
    'email': email,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'coordinates': coordinates.map((e) => e).toList(),
    'managerMobile': managerMobile,
    'managerName': managerName,
    'restaurantAddress': restaurantAddress,
    'restaurantName': restaurantName,
  };
}

class BankInformation {
  final String bankName;
  final String branchName;
  final String accountNumber;
  final String holderName;
  final String abaNumber;
  final String routingNumber;

  BankInformation({
    this.bankName = "",
    this.branchName = "",
    this.accountNumber = "",
    this.holderName = "",
    this.abaNumber = "",
    this.routingNumber = "",
  });

  factory BankInformation.fromJson(Map<String, dynamic>? json) => BankInformation(
    bankName: asT<String>(json, 'bankName'),
    branchName: asT<String>(json, 'branchName'),
    accountNumber: asT<String>(json, 'accountNumber'),
    holderName: asT<String>(json, 'holderName'),
    abaNumber: asT<String>(json, 'abaNumber'),
    routingNumber: asT<String>(json, 'routingNumber'),
  );

  Map<String, dynamic> toJson() => {
    'bankName': bankName,
    'branchName': branchName,
    'accountNumber': accountNumber,
    'holderName': holderName,
    'abaNumber': abaNumber,
    'routingNumber': routingNumber,
  };
}

