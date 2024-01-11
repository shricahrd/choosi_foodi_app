import 'dart:convert';

import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/model/login/vendorLogin/vendor_data_model.dart';
import 'package:choosifoodi/model/meta_data_model.dart';

LoginVendorModel LoginVendorModelFromJson(String str) =>
    LoginVendorModel.fromJson(json.decode(str));

String LoginDataModelToJson(LoginVendorModel data) => json.encode(data.toJson());

class LoginVendorModel {
  MetaDataModel meta;

  VendorDataModel? data;

  String? token;

  LoginVendorModel(this.meta, this.data, this.token);

  LoginVendorModel.fromJson(Map<String, dynamic> json)
      : meta = MetaDataModel.fromJson(json['meta']),
        data =
        json["data"] != null ? VendorDataModel.fromJson(json["data"]) : null,
        token = json["token"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta'] = meta;
    data['data'] = data;
    data['token'] = token;
    return data;
  }
}
