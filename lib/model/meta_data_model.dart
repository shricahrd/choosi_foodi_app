import 'dart:ffi';

class MetaDataModel {
  String msg;

  bool status;

  MetaDataModel(this.msg, this.status);

  MetaDataModel.fromJson(Map<String, dynamic> json)
      : msg = json['msg'],
        status = json["status"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    data['status'] = status;
    return data;
  }
}
