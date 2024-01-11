
import 'dart:convert';

LocationDetailsModel LocationDetailsModelFromJson(String str) =>
    LocationDetailsModel.fromJson(json.decode(str));

String LocationDetailsModelToJson(List<LocationDetailsModel> data) => json.encode(data);

class LocationDetailsModel{
  String address1 = "", address2 = "";

  LocationDetailsModel({required this.address1, required this.address2});

  Map<String, dynamic> toMap() {
    return {
      'address1': this.address1,
      'address2': this.address2,
    };
  }

  factory LocationDetailsModel.fromMap(Map<String, dynamic> map) {
    return LocationDetailsModel(
      address1: map['address1'] as String,
      address2: map['address2'] as String,
    );
  }

  LocationDetailsModel.fromJson(Map<String, dynamic> json)
      : address1 = json['address1'],
       address2 = json['address2'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address1'] = address1;
    data['address2'] = address2;
    return data;
  }
}