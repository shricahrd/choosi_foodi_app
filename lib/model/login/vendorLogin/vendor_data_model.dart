
import 'dart:convert';

VendorDataModel VendorDataModelFromJson(String str) =>
    VendorDataModel.fromJson(json.decode(str));

String VendorDataModelToJson(VendorDataModel data) => json.encode(data.toJson());

class VendorDataModel {
  String? vendorId;
  String? vendorName;
  String? email;
  String? mobile;
  IsCafe? isCafe;
  IsCafe? isHotel;
  IsCafe? isProfession;
  IsCafe? isRestaurant;
  IsCafe? isService;
  IsCafe? isShop;
  IsCafe? isCompany;
  bool? isRestaurantAdded;

  VendorDataModel({this.vendorId, this.vendorName, this.email, this.mobile, this.isCafe, this.isHotel, this.isProfession, this.isRestaurant, this.isService, this.isShop, this.isCompany, this.isRestaurantAdded});

  VendorDataModel.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendorId'];
    vendorName = json['vendorName'];
    email = json['email'];
    mobile = json['mobile'];
    isCafe = json['isCafe'] != null ? new IsCafe.fromJson(json['isCafe']) : null;
    isHotel = json['isHotel'] != null ? new IsCafe.fromJson(json['isHotel']) : null;
    isProfession = json['isProfession'] != null ? new IsCafe.fromJson(json['isProfession']) : null;
    isRestaurant = json['isRestaurant'] != null ? new IsCafe.fromJson(json['isRestaurant']) : null;
    isService = json['isService'] != null ? new IsCafe.fromJson(json['isService']) : null;
    isShop = json['isShop'] != null ? new IsCafe.fromJson(json['isShop']) : null;
    isCompany = json['isCompany'] != null ? new IsCafe.fromJson(json['isCompany']) : null;
    isRestaurantAdded = json['isRestaurantAdded'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendorId'] = this.vendorId;
    data['vendorName'] = this.vendorName;
    data['email'] = this.email;
    data['mobile'] = this.mobile;
    if (this.isCafe != null) {
      data['isCafe'] = this.isCafe!.toJson();
    }
    if (this.isHotel != null) {
      data['isHotel'] = this.isHotel!.toJson();
    }
    if (this.isProfession != null) {
      data['isProfession'] = this.isProfession!.toJson();
    }
    if (this.isRestaurant != null) {
      data['isRestaurant'] = this.isRestaurant!.toJson();
    }
    if (this.isService != null) {
      data['isService'] = this.isService!.toJson();
    }
    if (this.isShop != null) {
      data['isShop'] = this.isShop!.toJson();
    }
    if (this.isCompany != null) {
      data['isCompany'] = this.isCompany!.toJson();
    }
    data['isRestaurantAdded'] = this.isRestaurantAdded;
    return data;
  }
}

class IsCafe {
  IsCafe();

IsCafe.fromJson(Map<String, dynamic> json) {
}

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  return data;
}
}
