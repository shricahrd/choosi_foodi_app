class GetStateModel {
  Meta? meta;
  List<StateData>? data;

  GetStateModel({this.meta, this.data});

  GetStateModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <StateData>[];
      json['data'].forEach((v) {
        data!.add(new StateData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Meta {
  String? msg;
  bool? status;

  Meta({this.msg, this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['status'] = this.status;
    return data;
  }
}

class StateData {
  String? stateId;
  String? status;
  String? sId;
  String? countryName;
  String? countryId;
  String? stateName;
  int? createdAt;
  int? updatedAt;
  int? iV;

  StateData(
      {this.stateId,
        this.status,
        this.sId,
        this.countryName,
        this.countryId,
        this.stateName,
        this.createdAt,
        this.updatedAt,
        this.iV});

  StateData.fromJson(Map<String, dynamic> json) {
    stateId = json['stateId'];
    status = json['status'];
    sId = json['_id'];
    countryName = json['countryName'];
    countryId = json['countryId'];
    stateName = json['stateName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['stateId'] = this.stateId;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['countryName'] = this.countryName;
    data['countryId'] = this.countryId;
    data['stateName'] = this.stateName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
