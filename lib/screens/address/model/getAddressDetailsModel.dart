class GetAddressDetailsModel {
  Meta? meta;
  Data? data;

  GetAddressDetailsModel({this.meta, this.data});

  GetAddressDetailsModel.fromJson(Map<String, dynamic> json) {
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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

class Data {
  String? addressId;
  String? addressType;
  bool? isDefault;
  String? sId;
  String? userId;
  String? name;
  int? mobile;
  int? pincode;
  String? addressLine1;
  String? landmark;
  String? cityId;
  String? cityName;
  String? stateId;
  String? stateName;
  String? countryId;
  String? countryName;
  List<double>? coordinates;
  int? createdAt;
  int? updatedAt;
  int? iV;

  Data(
      {this.addressId,
        this.addressType,
        this.isDefault,
        this.sId,
        this.userId,
        this.name,
        this.mobile,
        this.pincode,
        this.addressLine1,
        this.landmark,
        this.cityId,
        this.cityName,
        this.stateId,
        this.stateName,
        this.countryId,
        this.countryName,
        this.coordinates,
        this.createdAt,
        this.updatedAt,
        this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    addressId = json['addressId'];
    addressType = json['addressType'];
    isDefault = json['isDefault'];
    sId = json['_id'];
    userId = json['userId'];
    name = json['name'];
    mobile = json['mobile'];
    pincode = json['pincode'];
    addressLine1 = json['addressLine1'];
    landmark = json['landmark'];
    cityId = json['cityId'];
    cityName = json['cityName'];
    stateId = json['stateId'];
    stateName = json['stateName'];
    countryId = json['countryId'];
    countryName = json['countryName'];
    coordinates = json['coordinates'].cast<double>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addressId'] = this.addressId;
    data['addressType'] = this.addressType;
    data['isDefault'] = this.isDefault;
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['pincode'] = this.pincode;
    data['addressLine1'] = this.addressLine1;
    data['landmark'] = this.landmark;
    data['cityId'] = this.cityId;
    data['cityName'] = this.cityName;
    data['stateId'] = this.stateId;
    data['stateName'] = this.stateName;
    data['countryId'] = this.countryId;
    data['countryName'] = this.countryName;
    data['coordinates'] = this.coordinates;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}
