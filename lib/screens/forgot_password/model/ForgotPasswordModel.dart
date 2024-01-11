/// meta : {"msg":"Otp has been sent to your mail !","status":true}
/// data : {"otp":6335}
import 'dart:convert';

ForgotPasswordModel forgotPasswordModelFromJson(String str) => ForgotPasswordModel.fromJson(json.decode(str));

String forgotPasswordModelToJson(ForgotPasswordModel data) => json.encode(data.toJson());

class ForgotPasswordModel {
  ForgotPasswordModel({
      Meta? meta,
      Data? data,}){
    _meta = meta;
    _data = data;
}

  ForgotPasswordModel.fromJson(dynamic json) {
    _meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  Meta? _meta;
  Data? _data;
ForgotPasswordModel copyWith({  Meta? meta,
  Data? data,
}) => ForgotPasswordModel(  meta: meta ?? _meta,
  data: data ?? _data,
);
  Meta? get meta => _meta;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_meta != null) {
      map['meta'] = _meta?.toJson();
    }
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// otp : 6335

class Data {
  Data({
      int? otp,}){
    _otp = otp;
}

  Data.fromJson(dynamic json) {
    _otp = json['otp'];
  }
  int? _otp;
Data copyWith({  int? otp,
}) => Data(  otp: otp ?? _otp,
);
  int? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['otp'] = _otp;
    return map;
  }

}

/// msg : "Otp has been sent to your mail !"
/// status : true

class Meta {
  Meta({
      String? msg,
      bool? status,}){
    _msg = msg;
    _status = status;
}

  Meta.fromJson(dynamic json) {
    _msg = json['msg'];
    _status = json['status'];
  }
  String? _msg;
  bool? _status;
Meta copyWith({  String? msg,
  bool? status,
}) => Meta(  msg: msg ?? _msg,
  status: status ?? _status,
);
  String? get msg => _msg;
  bool? get status => _status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['msg'] = _msg;
    map['status'] = _status;
    return map;
  }

}