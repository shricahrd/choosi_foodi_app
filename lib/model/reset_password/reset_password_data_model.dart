import 'dart:convert';

import 'package:choosifoodi/model/meta_data_model.dart';

ResetPasswordDataModel ResetPasswordDataModelFromJson(String str) =>
    ResetPasswordDataModel.fromJson(json.decode(str));

String ResetPasswordDataModelToJson(ResetPasswordDataModel data) =>
    json.encode(data.toJson());

class ResetPasswordDataModel {
  MetaDataModel meta;

  ResetPasswordDataModel(this.meta);

  ResetPasswordDataModel.fromJson(Map<String, dynamic> json)
      : meta = MetaDataModel.fromJson(json['meta']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta'] = meta;
    return data;
  }
}
