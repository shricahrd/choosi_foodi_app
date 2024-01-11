class ChangePwdModel {
  ChangePwdModel({
    required this.meta,
  });

  late final Meta meta;

  ChangePwdModel.fromJson(Map<String, dynamic> json) {
    meta = Meta.fromJson(json['meta']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['meta'] = meta.toJson();
    return _data;
  }
}

class Meta {
  Meta({
    required this.msg,
    required this.status,
  });

  late final String msg;
  late final bool status;

  Meta.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['msg'] = msg;
    _data['status'] = status;
    return _data;
  }
}
