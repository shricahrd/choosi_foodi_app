

import '../../../home/model/safe_convert.dart';

class VendorSignupModel {
  final Meta? meta;
  final Data? data;

  VendorSignupModel({
     this.meta,
     this.data,
  });

  factory VendorSignupModel.fromJson(Map<String, dynamic>? json) => VendorSignupModel(
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
  final String vendorId;
  final List<dynamic> vendorDocument;
  final List<dynamic> vendorImg;
  final bool otpVerified;
  final bool isLogin;
  final bool isAddedByAdmin;
  final bool isSignupComplete;
  final String state;
  final String status;
  final String id;
  final String mobile;
  final int mobileOtp;
  final int createdAt;
  final int updatedAt;
  final int v;
  final String email;
  final String password;
  final String vendorName;
  final String restaurantId;

  Data({
    this.vendorId = "",
    required this.vendorDocument,
    required this.vendorImg,
    this.otpVerified = false,
    this.isLogin = false,
    this.isAddedByAdmin = false,
    this.isSignupComplete = false,
    this.state = "",
    this.status = "",
    this.id = "",
    this.mobile = "",
    this.mobileOtp = 0,
    this.createdAt = 0,
    this.updatedAt = 0,
    this.v = 0,
    this.email = "",
    this.password = "",
    this.vendorName = "",
    this.restaurantId = "",
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
    vendorId: asT<String>(json, 'vendorId'),
    vendorDocument: asT<List>(json, 'vendorDocument').map((e) => e.toString()).toList(),
    vendorImg: asT<List>(json, 'vendorImg').map((e) => e.toString()).toList(),
    otpVerified: asT<bool>(json, 'otpVerified'),
    isLogin: asT<bool>(json, 'isLogin'),
    isAddedByAdmin: asT<bool>(json, 'isAddedByAdmin'),
    isSignupComplete: asT<bool>(json, 'isSignupComplete'),
    state: asT<String>(json, 'state'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    mobile: asT<String>(json, 'mobile'),
    mobileOtp: asT<int>(json, 'mobileOtp'),
    createdAt: asT<int>(json, 'createdAt'),
    updatedAt: asT<int>(json, 'updatedAt'),
    v: asT<int>(json, '__v'),
    email: asT<String>(json, 'email'),
    password: asT<String>(json, 'password'),
    vendorName: asT<String>(json, 'vendorName'),
    restaurantId: asT<String>(json, 'restaurantId'),
  );

  Map<String, dynamic> toJson() => {
    'vendorId': vendorId,
    'vendorDocument': vendorDocument.map((e) => e).toList(),
    'vendorImg': vendorImg.map((e) => e).toList(),
    'otpVerified': otpVerified,
    'isLogin': isLogin,
    'isAddedByAdmin': isAddedByAdmin,
    'isSignupComplete': isSignupComplete,
    'state': state,
    'status': status,
    '_id': id,
    'mobile': mobile,
    'mobileOtp': mobileOtp,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'email': email,
    'password': password,
    'vendorName': vendorName,
    'restaurantId': restaurantId,
  };
}

