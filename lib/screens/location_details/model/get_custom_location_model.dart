class GetCustomLocationModel {
  dynamic address1;
  dynamic address2;
  dynamic lat;
  dynamic long;

  GetCustomLocationModel({required this.address1, required this.address2,required this.lat,required this.long, });

  factory GetCustomLocationModel.fromJson(Map<String, dynamic> json) {
    return GetCustomLocationModel(
      address1: json["address1"],
      address2: json["address2"],
      lat: json["lat"],
      long: json["long"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'address1': this.address1,
      'address2': this.address2,
      'lat': this.lat,
      'long': this.long,
    };
  }

  factory GetCustomLocationModel.fromMap(Map<String, dynamic> map) {
    return GetCustomLocationModel(
      address1: map['address1'] as dynamic,
      address2: map['address2'] as dynamic,
      lat: map['lat'] as dynamic,
      long: map['long'] as dynamic,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "address1": address1,
      "address2": address2,
      "lat": lat,
      "long": long,
    };
  }

}
