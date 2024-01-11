import 'dart:convert';
import '../../home/model/safe_convert.dart';

SocialData SocialDataModelFromJson(String str) =>
    SocialData.fromJson(json.decode(str));

String SocialDataModelToJson(SocialData data) => json.encode(data.toJson());

class SocialLoginModel {
  final Meta? meta;
  final SocialData? data;
  final String token;

  SocialLoginModel({
     this.meta,
     this.data,
    this.token = "",
  });

  factory SocialLoginModel.fromJson(Map<String, dynamic>? json) => SocialLoginModel(
    meta: Meta.fromJson(asT<Map<String, dynamic>>(json, 'meta')),
    data: SocialData.fromJson(asT<Map<String, dynamic>>(json, 'data')),
    token: asT<String>(json, 'token'),
  );

  Map<String, dynamic> toJson() => {
    'meta': meta?.toJson(),
    'data': data?.toJson(),
    'token': token,
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


class SocialData {
  final String userId;
  final bool isLogin;
  final bool isMobileOtpValid;
  final bool otpVerified;
  final bool newUser;
  final String gender;
  final String userGoal;
  final String activityLevel;
  final String loginType;
  final String status;
  final String id;
  final String email;
  final String mobile;
  final String authId;
  final int v;

  SocialData({
    this.userId = "",
    this.isLogin = false,
    this.isMobileOtpValid = false,
    this.otpVerified = false,
    this.newUser = false,
    this.gender = "",
    this.userGoal = "",
    this.activityLevel = "",
    this.loginType = "",
    this.status = "",
    this.id = "",
    this.email = "",
    this.mobile = "",
    this.authId = "",
    this.v = 0,
  });

  factory SocialData.fromJson(Map<String, dynamic>? json) => SocialData(
    userId: asT<String>(json, 'userId'),
    isLogin: asT<bool>(json, 'isLogin'),
    isMobileOtpValid: asT<bool>(json, 'isMobileOtpValid'),
    otpVerified: asT<bool>(json, 'otpVerified'),
    newUser: asT<bool>(json, 'newUser'),
    gender: asT<String>(json, 'gender'),
    userGoal: asT<String>(json, 'userGoal'),
    activityLevel: asT<String>(json, 'activityLevel'),
    loginType: asT<String>(json, 'loginType'),
    status: asT<String>(json, 'status'),
    id: asT<String>(json, '_id'),
    email: asT<String>(json, 'email'),
    mobile: asT<String>(json, 'mobile'),
    authId: asT<String>(json, 'authId'),
    v: asT<int>(json, '__v'),
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'isLogin': isLogin,
    'isMobileOtpValid': isMobileOtpValid,
    'otpVerified': otpVerified,
    'newUser': newUser,
    'gender': gender,
    'userGoal': userGoal,
    'activityLevel': activityLevel,
    'loginType': loginType,
    'status': status,
    '_id': id,
    'email': email,
    'mobile': mobile,
    'authId': authId,
    '__v': v,
  };
}

