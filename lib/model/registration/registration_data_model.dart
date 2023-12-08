import 'dart:convert';

import 'package:choosifoodi/model/meta_data_model.dart';

RegistrationDataModel RegistrationDataModelFromJson(String str) =>
    RegistrationDataModel.fromJson(json.decode(str));

String RegistrationDataModelToJson(RegistrationDataModel data) =>
    json.encode(data.toJson());

class RegistrationDataModel {
  MetaDataModel meta;

  RegistrationDataModel(this.meta);

  RegistrationDataModel.fromJson(Map<String, dynamic> json)
      : meta = MetaDataModel.fromJson(json['meta']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['meta'] = meta;
    return data;
  }
}
