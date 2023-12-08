import 'dart:convert';

import 'package:choosifoodi/model/meta_data_model.dart';

ForgotPasswordDataModel ForgotPasswordDataModelFromJson(String str) =>
    ForgotPasswordDataModel.fromJson(json.decode(str));

String ForgotPasswordDataModelToJson(ForgotPasswordDataModel data) =>
    json.encode(data.toJson());

class ForgotPasswordDataModel {
  MetaDataModel meta;

  ForgotPasswordDataModel(this.meta);

  ForgotPasswordDataModel.fromJson(Map<String, dynamic> json)
      : meta = MetaDataModel.fromJson(json['meta']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta'] = meta;
    return data;
  }
}
