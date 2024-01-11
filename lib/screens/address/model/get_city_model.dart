class GetCityModel {
  Meta? meta;
  List<CityData>? data;

  GetCityModel({this.meta, this.data});

  GetCityModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    if (json['data'] != null) {
      data = <CityData>[];
      json['data'].forEach((v) {
        data!.add(new CityData.fromJson(v));
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

class CityData {
  String? cityId;
  String? status;
  String? sId;
  String? countryName;
  String? countryId;
  String? stateName;
  String? stateId;
  String? cityName;
  int? createdAt;
  int? updatedAt;
  int? iV;

  CityData(
      {this.cityId,
        this.status,
        this.sId,
        this.countryName,
        this.countryId,
        this.stateName,
        this.stateId,
        this.cityName,
        this.createdAt,
        this.updatedAt,
        this.iV});

  CityData.fromJson(Map<String, dynamic> json) {
    cityId = json['cityId'];
    status = json['status'];
    sId = json['_id'];
    countryName = json['countryName'];
    countryId = json['countryId'];
    stateName = json['stateName'];
    stateId = json['stateId'];
    cityName = json['cityName'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cityId'] = this.cityId;
    data['status'] = this.status;
    data['_id'] = this.sId;
    data['countryName'] = this.countryName;
    data['countryId'] = this.countryId;
    data['stateName'] = this.stateName;
    data['stateId'] = this.stateId;
    data['cityName'] = this.cityName;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
