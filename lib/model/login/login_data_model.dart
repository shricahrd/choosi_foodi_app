import 'dart:convert';

import 'package:choosifoodi/model/login/user_data_model.dart';
import 'package:choosifoodi/model/meta_data_model.dart';

LoginDataModel LoginDataModelFromJson(String str) =>
    LoginDataModel.fromJson(json.decode(str));

String LoginDataModelToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginDataModel {
  MetaDataModel meta;

  UserDataModel? data;

  String? token;

  LoginDataModel(this.meta, this.data, this.token);

  LoginDataModel.fromJson(Map<String, dynamic> json)
      : meta = MetaDataModel.fromJson(json['meta']),
        data =
            json["data"] != null ? UserDataModel.fromJson(json["data"]) : null,
        token = json["token"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta'] = meta;
    data['data'] = data;
    data['token'] = token;
    return data;
  }
}
